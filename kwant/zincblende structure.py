# Tutorial 2.7.2. 3D example: zincblende structure
# ================================================
#
# Physical background
# -------------------
#  - 3D Bravais lattices
#
# Kwant features highlighted
# --------------------------
#  - demonstrate different ways of plotting in 3D

import kwant
from matplotlib import pyplot

lat = kwant.lattice.general([(0, 0.5, 0.5), (0.5, 0, 0.5), (0.5, 0.5, 0)],
                            [(0, 0, 0), (0.25, 0.25, 0.25)])
a, b = lat.sublattices

def make_cuboid(a=15, b=10, c=5):
    def cuboid_shape(pos):
        x, y, z = pos
        return 0 <= x < a and 0 <= y < b and 0 <= z < c

    sys = kwant.Builder()
    sys[lat.shape(cuboid_shape, (0, 0, 0))] = None
    sys[lat.neighbors()] = None

    return sys


def main():
    # the standard plotting style for 3D is mainly useful for
    # checking shapes:
    sys = make_cuboid()

    kwant.plot(sys)

    # visualize the crystal structure better for a very small system
    sys = make_cuboid(a=1.5, b=1.5, c=1.5)

    def family_colors(site):
        return 'r' if site.family == a else 'g'

    kwant.plot(sys, site_size=0.18, site_lw=0.01, hop_lw=0.05,
               site_color=family_colors)


# Call the main function if the script gets executed (as opposed to imported).
# See <http://docs.python.org/library/__main__.html>.
if __name__ == '__main__':
    main()

