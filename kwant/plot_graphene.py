# Tutorial 2.7.1. 2D example: graphene quantum dot
"""modified to include an octave geometry"""
# ================================================
#
# Physics background
# ------------------
#  - graphene edge states
#
# Kwant features highlighted
# --------------------------
#  - demonstrate different ways of plotting

import kwant
from matplotlib import pyplot
from numpy import arctan
from math import cos

lat = kwant.lattice.honeycomb()
a, b = lat.sublattices

#r: dot size
#t: nearest hopping
#tp: second nearest hopping
def make_system(r=20, t=-1, tp=0):


    def octave(pos):
        x, y = pos
        if x==0:
            return True
        #r_max = r / cos( divmod( arctan( y / (x+0.000001) ), 15*3.14159/180 )[1] )
        else:
            r_max = r / cos( divmod( arctan( y / x ) + 0.261799387799, 
                0.523598775598 )[1] - 0.261799387799)
            return x**2 + y**2 < r_max**2

    sys = kwant.Builder()
    sys[lat.shape(octave, (0, 0))] = 0
    sys[lat.neighbors()] = t
    sys.eradicate_dangling()
    if tp:
        sys[lat.neighbors(2)] = tp

    return sys


def plot_system(sys):
    kwant.plot(sys)
    # the standard plot is ok, but not very intelligible. One can do
    # better by playing with colors and linewidths

    # use color and linewidths to get a better plot
    def family_color(site):
        return 'black' if site.family == a else 'white'

    def hopping_lw(site1, site2):
        return 0.04 if site1.family == site2.family else 0.1

    kwant.plot(sys, site_lw=0.1, site_color=family_color, hop_lw=hopping_lw)



#############
def plot_bandstructure(flead, momenta):
    bands = kwant.physics.Bands(flead)
    energies = [bands(k) for k in momenta]

    pyplot.figure()
    pyplot.plot(momenta, energies)
    pyplot.xlabel("momentum [(lattice constant)^-1]")
    pyplot.ylabel("energy [t]")
    pyplot.show()


def plot_data(sys, n):
    import scipy.linalg as la

    sys = sys.finalized()
    ham = sys.hamiltonian_submatrix()
    evecs = la.eigh(ham)[1]

    wf = abs(evecs[:, n])**2

    # the usual - works great in general, looks just a bit crufty for
    # small systems

    kwant.plotter.map(sys, wf, oversampling=10, cmap='gist_heat_r')

    # use two different sort of triangles to cleanly fill the space
    def family_shape(i):
        site = sys.site(i)
        return ('p', 3, 180) if site.family == a else ('p', 3, 0)

    def family_color(i):
        return 'black' if sys.site(i).family == a else 'white'

    kwant.plot(sys, site_color=wf, site_symbol=family_shape,
               site_size=0.5, hop_lw=0, cmap='gist_heat_r')

    # plot by changing the symbols itself
    def site_size(i):
        return 3 * wf[i] / wf.max()

    kwant.plot(sys, site_size=site_size, site_color=(0, 0, 1, 0.3),
               hop_lw=0.1)


def main():
    # plot the graphene system in different styles
    sys = make_system()

    ###############
    """this plot the system config"""
    #plot_system(sys)

    # compute a wavefunction (number 225) and plot it in different
    # styles
    sys = make_system(tp=0)


    ###############
    """this plot the state distribution of the n-th energy level,
        n being the second argument"""
    plot_data(sys, 50)




    sys = sys.finalized()

    ##################will return no leads error
    #def density(sys, energy, args, lead_nr):
    #    wf = kwant.wave_function(sys, energy, args)
    #    return (abs(wf(lead_nr))**2).sum(axis=0)
    #
    #energy = 0.15    
    #d = density(sys, energy, [], 0)
    #kwant.plotter.map(sys, d)



    # Compute the band structure of lead 0.
    pi = 3.14159265359
    momenta = [-pi + 0.02 * pi * i for i in xrange(101)]
    ######################
    #plot_bandstructure(sys, momenta)





# Call the main function if the script gets executed (as opposed to imported).
# See <http://docs.python.org/library/__main__.html>.
if __name__ == '__main__':
    main()

