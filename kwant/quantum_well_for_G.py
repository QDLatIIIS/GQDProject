# Tutorial 2.3.2. Spatially dependent values through functions
# ============================================================
#
# Physics background
# ------------------
#  transmission through a quantum well
#
# Kwant features highlighted
# --------------------------
#  - Functions as values in Builder
from __future__ import division  # so that 1/2 == 0.5, and not 0

import kwant

# For plotting
from matplotlib import pyplot
from math import pi, sqrt, tanh

# For computing eigenvalues
import scipy.sparse.linalg as sla
import scipy.linalg as la


sin_30, cos_30 = (1 / 2, sqrt(3) / 2)


graphene = kwant.lattice.general([(1, 0), (sin_30, cos_30)],
                                 [(0, 0), (0, 1 / sqrt(3))])
a, b = graphene.sublattices

# r determines the size of the dot!!!!
def make_system(r=20, w=2.0, pot=1, t=1):
    # Start with an empty tight-binding system and a single circle lattice.
    # `a` is the lattice constant (by default set to 1 for simplicity.
    

    sys = kwant.Builder()

    def circle(pos):
        x, y = pos
        return x ** 2 + y ** 2 < r ** 2

    #### Define the scattering region. ####
    # Potential profile
    def potential(site):
        x, y = site.pos
        if abs(x)>0.7*r :
            return 0 + t
        elif (x**2 + y**2) < 0.3*r**2 :
            return 0 + t
        elif abs(y) < 0.05*r :
            return 0.5*pot + t
        else:
            return pot + t

    #def potential(site):
    #    x, y = site.pos
    #    rsq = x**2 + y**2
    #    return t * rsq/(r**2) + 4*t

    #def onsite(site, pot=0):
    #    return 4 * t + potential(site, pot)

    
    sys[graphene.shape(circle, (0, 0))] = potential
    

    # specify the hoppings of the graphene lattice in the
    # format expected by builder.HoppingKind
    hoppings = (((0, 0), a, b), ((0, 1), a, b), ((-1, 1), a, b))
    sys[[kwant.builder.HoppingKind(*hopping) for hopping in hoppings]] = -t

    ############previous symmetry
    sym0 = kwant.TranslationalSymmetry([1.5, -sqrt(3)/2])
    #sym0 = kwant.TranslationalSymmetry([1, 0])

    def lead_shape(pos):
        x, y = pos
        return (-0.4 * r < y < 0.4 * r)

    lead0 = kwant.Builder(sym0)
    lead0[graphene.shape(lead_shape, (0, 0))] = -pot
    lead0[[kwant.builder.HoppingKind(*hopping) for hopping in hoppings]] = -1

    # The second lead, going to the top right
    #################
    sym1 = kwant.TranslationalSymmetry([-1.5, sqrt(3)/2])
    #sym1 = kwant.TranslationalSymmetry([-1, 0])

    """this is the upper left lead"""
    lead1 = kwant.Builder(sym1)
    lead1[graphene.shape(lead_shape, (0, 0))] = pot
    lead1[[kwant.builder.HoppingKind(*hopping) for hopping in hoppings]] = -1
    #sys.attach_lead(lead0)
    #sys.attach_lead(lead1)

    return sys, [lead0, lead1]


def compute_evs(sys):
    # Compute some eigenvalues of the closed system
    sparse_mat = sys.hamiltonian_submatrix(sparse=True)

    evs = sla.eigs(sparse_mat, 2)[0]
    print evs.real


def plot_bandstructure(flead, momenta):
    bands = kwant.physics.Bands(flead)
    energies = [bands(k) for k in momenta]

    pyplot.figure()
    pyplot.plot(momenta, energies)
    pyplot.xlabel("momentum [(lattice constant)^-1]")
    pyplot.ylabel("energy [t]")
    pyplot.show()


def plot_conductance(sys, energies):
    # Compute transmission as a function of energy
    data = []
    for energy in energies:
        smatrix = kwant.smatrix(sys, energy)
        data.append(smatrix.transmission(0, 1))

    pyplot.figure()
    pyplot.plot(energies, data)
    pyplot.xlabel("energy [t]")
    pyplot.ylabel("conductance [e^2/h]")
    pyplot.show()

def plot_data(sys, n):
    import scipy.linalg as la

    sys = sys.finalized()
    ham = sys.hamiltonian_submatrix()
    evecs = la.eigh(ham)[1]

    wf = abs(evecs[:, n])**2

    # the usual - works great in general, looks just a bit crufty for
    # small systems

    """usual plot, no lattice"""
    #kwant.plotter.map(sys, wf, oversampling=10, cmap='gist_heat_r')

    # use two different sort of triangles to cleanly fill the space
    def family_shape(i):
        site = sys.site(i)
        return ('p', 3, 180) if site.family == a else ('p', 3, 0)

    def family_color(i):
        return 'black' if sys.site(i).family == a else 'white'

    """use color to show the weight of different site"""
    #want.plot(sys, site_color=wf, site_symbol=family_shape,
    #           site_size=0.5, hop_lw=0, cmap='gist_heat_r')

    # plot by changing the symbols itself
    def site_size(i):
        return 3 * wf[i] / wf.max()

    """use different size of circle"""
    kwant.plot(sys, site_size=site_size, site_color=(0, 0, 1, 0.3),
               hop_lw=0.1)


def main():
    sys, leads = make_system(r=50)


    # To highlight the two sublattices of graphene, we plot one with
    # a filled, and the other one with an open circle:
    def family_colors(site):
        return 0 if site.family == a else 1

    # Check that the system looks as intended.
    """Plot the system"""
    #kwant.plot(sys, site_color=family_colors, site_lw=0.1, colorbar=False)

    ##############
    #compute_evs(sys.finalized())


    # Attach the leads to the system.
    for lead in leads:
        sys.attach_lead(lead)


    # Plot the system with leads.    
    """Plot the system with leads"""
    #kwant.plot(sys, site_color=family_colors, site_lw=0.1,
    #           lead_site_lw=0, colorbar=False)
    
    """plotting the state distribution, 2nd args is the order of it"""
    #plot_data(sys, 2)

    sys = sys.finalized()

    # Compute the band structure of lead 0.
    momenta = [-pi + 0.02 * pi * i for i in xrange(101)]
    #######################
    """Compute the band structure of lead 0"""
    #plot_bandstructure(sys.leads[0], momenta)



    # Plot conductance.
    pot = 0.1
    energies = [0 * pot + 10. / 200. * pot * i for i in xrange(401)]
    ####################
    """Plot conductance"""
    plot_conductance(sys, energies)


    def density(sys, energy, args, lead_nr):
        wf = kwant.wave_function(sys, energy, args)
        return (abs(wf(lead_nr))**2).sum(axis=0)
    
    energy = 0.5
    d = density(sys, energy, [], 0)

    #####
    """these below cost huge memory"""
    #ham = sys.hamiltonian_submatrix()
    #evecs = la.eigh(ham)[1]
    #wf = abs(evecs[:, n])**2
    #kwant.plotter.map(sys, wf, oversampling=10, cmap='gist_hear_r')

    """don't know the meaning"""
    kwant.plotter.map(sys, d)




# Call the main function if the script gets executed (as opposed to imported).
# See <http://docs.python.org/library/__main__.html>.
if __name__ == '__main__':
    main()

