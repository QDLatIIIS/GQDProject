#generate trilayer graphene

from __future__ import division  # so that 1/2 == 0.5, and not 0

import kwant

# For plotting
from matplotlib import pyplot
from math import pi, sqrt, tanh
from cmath import exp
import numpy as np

# For computing eigenvalues
import scipy.sparse.linalg as sla
import scipy.linalg as la

sin_30, cos_30 = (1 / 2, sqrt(3) / 2)

def make_system(r=20, a=0.246, t=3.0, dis_z=0.335, t2 = 0.4):
	"""not work, don't know why so far"""
	#BLG = kwant.lattice.general([a*(1, 0, 0),a*(sin_30, cos_30, 0)], basis=[(0, 1/sqrt(3), 0), (0, 0, 0), (1/2, sqrt(3)/2, dis_z), (1/2, 1/( 2*sqrt(3) ), dis_z)])
	BLG = kwant.lattice.general([(a, 0, 0), (a*sin_30, a*cos_30, 0), (a*1/2, a*1/(2*sqrt(3)), dis_z)], 
		[(0, a*1/sqrt(3), 0), (0, 0, 0)])

	#a1, b1, a2, b2 = BLG.sublattices
	a1, b1 = BLG.sublattices



	def circle(pos):
		x, y, z = pos
		rsq = x**2 + y**2
		return rsq < r**2 and -0.7*dis_z < z < 2.1*dis_z

	"""tangent square potential"""

	def onsiteVer2(site, *args):
		x, y, z = site.pos
		r_reduced = np.sqrt(x**2+y**2)/(r + 1)
		return t * np.tan(r_reduced * np.pi / 2) ** 2 + 4 * t

	"""quadratic potential"""

	def onsite(site, B=0, U=1):
		x, y, z = site.pos
		rsq = x**2+y**2
		"""for double layer"""
		if z > dis_z/2:
			return U * (rsq/r**2)*t + 4*t
		else:
			return - (U * (rsq/r**2)*t + 4*t)
		"""for single layer"""
		#return U * (rsq/r**2)*t + 4*t


	"""describing B field"""
	def hopB(site1, site2, B=0, U=1):
		dx = abs(site1.pos[0] - site2.pos[0])
		y = site1.pos[1]
		ymid = (site1.pos[1] + site2.pos[1])/2
		dz = abs(site1.pos[2] - site2.pos[2])
		if dz > 0.1 * a:
			return 0
		"""The constant 0.0000151927 is due to units(length in 10^-10 m)
		   Doesn't work
		"""
		#return	-t *exp(-1j *0.0000151927* B * y * dx)
		"""Try not using the constant:"""
		#print -t *exp(-1j * B * ymid * dx)
		return	-t *exp(-1j * B * ymid * dx)


	sys = kwant.Builder()
	sys[BLG.shape(circle, (0, 0, 0))] = 0#onsite
	"""no B field"""
	#sys[BLG.neighbors()] = -t
	"""add B field"""
	#print BLG.neighbors()[0]
	sys[BLG.neighbors()] = hopB


	def interLayerHopping():
		sites = sys.sites()
		for site1 in sites:
			if a1.pos(site1.tag)[2] == dis_z:
				if site1.family == a1:
					for site2 in sites:
						if site2.family == b1 and b1.pos(site2.tag)[2] == 0:
							if abs(a1.pos(site1.tag)[0] - b1.pos(site2.tag)[0]) < 0.1*a:
								if abs(a1.pos(site1.tag)[1] - b1.pos(site2.tag)[1]) < 0.1*a:
									yield site1, site2
				else:
					for site2 in sites:
						if site2.family == a1 and a1.pos(site2.tag)[2] == 2*dis_z:
							if abs(b1.pos(site1.tag)[0] - a1.pos(site2.tag)[0]) < 0.1*a:
								if abs(b1.pos(site1.tag)[1] - a1.pos(site2.tag)[1]) < 0.1*a:
									yield site1, site2

	"""add interlayer hopping"""
	sys[interLayerHopping()] = t2


	return sys, BLG

def plot_system(sys, lat):
    #kwant.plot(sys)
    # the standard plot is ok, but not very intelligible. One can do
    # better by playing with colors and linewidths

    # use color and linewidths to get a better plot
    a1, b1 = lat.sublattices
    def family_color(site):
        return 'black' if site.family == a1 else 'white'

    def hopping_lw(site1, site2):
        return 0.04 if site1.family == site2.family else 0.1

    # for interlayer hopping, use smaller linewidth
    def hopping_lw_thinInter(site1, site2, dis_z=3.35, a=2.46):
		#print "hopping_lw function called"
		sites = sys.sites()
		if a1.pos(site1.tag)[2] == dis_z:
			if site1.family == a1:
				if site2.family == b1 and b1.pos(site2.tag)[2] == 0:
					if abs(a1.pos(site1.tag)[0] - b1.pos(site2.tag)[0]) < 0.1*a:
						if abs(a1.pos(site1.tag)[1] - b1.pos(site2.tag)[1]) < 0.1*a:
							print "get!"
							return 0.02

			else:
				if site2.family == a1 and a1.pos(site2.tag)[2] == 2*dis_z:
					if abs(b1.pos(site1.tag)[0] - a1.pos(site2.tag)[0]) < 0.1*a:
						if abs(b1.pos(site1.tag)[1] - a1.pos(site2.tag)[1]) < 0.1*a:
							return 0.02
		return 0.05

    #kwant.plot(sys, site_size = 0.15, site_lw=0.05, site_color=family_color, hop_lw=0.05)
    kwant.plot(sys, site_size = 0.15, site_lw=0.04, site_color=family_color, hop_lw=hopping_lw_thinInter)



def plot_wave_function(sys, numOfEigenVec=15):
	# Calculate the wave functions in the system.
	ham_mat = sys.hamiltonian_submatrix(sparse=True)
	#print "ham mat:"
	#print ham_mat
	evecs = sla.eigsh(ham_mat, k=(numOfEigenVec+1), which='SM')[1]
	#print "evecs:"
	#print evecs

	# Plot the probability density of the 10th eigenmode.
	"""cannot use in 3D"""
	#kwant.plotter.map(sys, np.abs(evecs[:, numOfEigenVec])**2,
	#                  colorbar=False, oversampling=1)
	sites = sys.sites()
	x=[]
	y=[]

	for site in sites:
		pos = site.family.pos(site.tag)[0]
		x.append(pos[0])
		y.append(pos[1])


def plot_spectrum(sys, Bfields, numOfEnLevel=15):

    # In the following, we compute the spectrum of the quantum dot
    # using dense matrix methods. This works in this toy example, as
    # the system is tiny. In a real example, one would want to use
    # sparse matrix methods

    energies = []
    for B in Bfields:
        # Obtain the Hamiltonian as a dense matrix
        ham_mat = sys.hamiltonian_submatrix(args=[B], sparse=True)

        # we only calculate the 15 lowest eigenvalues
        """modified k(original 15)"""
        ev = sla.eigsh(ham_mat, k=numOfEnLevel, which='SM', return_eigenvectors=False)

        for i in range(len(ev)):
        	for j in np.arange(i+1, len(ev),1):
        		if ev[j] > ev[i]:
        			temp = ev[i]
        			ev[i] = ev[j]
        			ev[j] = temp
        energies.append(ev)

    pyplot.figure()
    pyplot.plot(Bfields, energies)
    pyplot.xlabel("magnetic field [T]")
    pyplot.ylabel("energy [t]")
    pyplot.show()

def plot_EvsU(sys, Us, numOfEnLevel=15):

    # In the following, we compute the spectrum of the quantum dot
    # using dense matrix methods. This works in this toy example, as
    # the system is tiny. In a real example, one would want to use
    # sparse matrix methods

    energies = []
    for u in Us:
        # Obtain the Hamiltonian as a dense matrix
        ham_mat = sys.hamiltonian_submatrix(args=[0, u], sparse=True)

        # we only calculate the 15 lowest eigenvalues
        """modified k(original 15)"""
        ev = sla.eigsh(ham_mat, k=numOfEnLevel, which='SM', return_eigenvectors=False)
        #print ev
        for i in range(len(ev)):
        	for j in np.arange(i+1, len(ev),1):
        		if ev[j] > ev[i]:
        			temp = ev[i]
        			ev[i] = ev[j]
        			ev[j] = temp
        energies.append(ev)

    pyplot.figure()
    pyplot.plot(Us, energies)
    pyplot.xlabel("Potential height [t (at $r_0$)]")
    pyplot.ylabel("energy [t]")
    pyplot.show()

def main():
	sys, BLG = make_system(r=3, a=2.46, dis_z=3.35)

	#kwant.plot(sys)
	plot_system(sys, BLG)

	a1, b1 = BLG.sublattices

	#sites = sys.sites()
	#for site in sites:
	#	print BLG.pos(site.tag())

	#print [site.family.pos(site.tag) for site in sys.sites()]


	# The following try-clause can be removed once SciPy 0.9 becomes uncommon.
	try:
		# We should observe energy levels that flow towards Landau
		# level energies with increasing magnetic field.
		"""
			plot spectrum
			modified the range of B field(original xrange(100))
		"""
		#print "plotting spectrum..."
		#plot_spectrum(sys.finalized(), [iB * 0.01 for iB in xrange(1500)], numOfEnLevel=30)
		#print "Done."

		"""plot E vs U"""
		#print "plotting E vs U..."
		#plot_EvsU(sys.finalized(), [iU * 0.1 for iU in xrange(100)], numOfEnLevel=50)
		#print "Done."

		# Plot an eigenmode of a circular dot. Here we create a larger system for
		# better spatial resolution.
		"""rebuild system(original r=30)"""
		#sys = make_system(r=50).finalized()
		#plot_wave_function(sys.finalized() , numOfEigenVec=10)
	except ValueError as e:
		if e.message == "Input matrix is not real-valued.":
			print "The calculation of eigenvalues failed because of a bug in SciPy 0.9."
			print "Please upgrade to a newer version of SciPy."
		else:
			raise

	"""interlayer hopping function test
		def interLayerHopping():
			sites = sys.sites()
			for site1 in sites:
				if site1.family.pos(site1.tag)[2] == 0:
					for site2 in sites:
						if site2.family.pos(site2.tag)[2] == 1.0:
							if (site1.family.pos(site1.tag)[0] - site2.family.pos(site2.tag)[0])<0.1:
								if (site1.family.pos(site1.tag)[1] - site2.family.pos(site2.tag)[1])<0.1:
									yield site1, site2
		
		hops = interLayerHopping()
		print [(hop[0].pos ,hop[1].pos) for hop in hops]
	"""

# Call the main function if the script gets executed (as opposed to imported).
# See <http://docs.python.org/library/__main__.html>.
if __name__ == '__main__':
    main()