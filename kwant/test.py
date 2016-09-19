
#import numpy as np
    #from numpy import arctan,cos
    #import matplotlib.pyplot as plt
    #import mpl_toolkits.mplot3d
    #
    #x,y=np.mgrid[-2:2:50j,-2:2:50j]
    #z = 1 / cos( divmod( arctan( y / x ) + 0.261799387799, 0.523598775598 )[1] - 0.261799387799)
    #
    #ax=plt.subplot(111,projection='3d')
    #ax.plot_surface(x,y,z,rstride=2,cstride=1,cmap=plt.cm.coolwarm,alpha=1)
    #ax.set_xlabel('x')
    #ax.set_ylabel('y')
    #ax.set_zlabel('z')
    #plt.savefig('testPlot.pdf')
    #plt.show()

"""
    print arctan(5.2/3.2)
    print divmod(5.2,3.1)[1]
    print 15*3.14159/180
    x,y=np.mgrid[-2:2:2j,-2:2:2j]
    print x
    print y
    print arctan( y / x )
    print 30*3.14159265359/180
    print divmod( arctan( y / x ), 0.261799387799 )[1]
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
    
    ######3D modeling
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
"""

#import kwant
#print kwant.__version__
import matplotlib as mpl

"""
###command below can disable plt.show()'s output
###must be used before importing pyplot
"""
#mpl.use('Agg')

import matplotlib.pyplot as plt
import numpy as np

def octave():
    from numpy import arctan,cos
    import mpl_toolkits.mplot3d
    x,y=np.mgrid[-2:2:50j,-2:2:50j]
    z = 1 / cos( divmod( arctan( y / x ) + 0.261799387799, 0.523598775598 )[1] - 0.261799387799)
    ax=plt.subplot(111,projection='3d')
    ax.plot_surface(x,y,z,rstride=2,cstride=1,cmap=plt.cm.coolwarm,alpha=1)
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_zlabel('z')
    plt.savefig('testPlot.pdf')
    plt.show()
    plt.close()

def plotExample():
    x = np.arange(1, 40, 1)
    plt.plot(x, x *2, 'b:' ,label='Normal')
    plt.plot(x, x*3.0, 'r-.' ,label='Fast')
    plt.plot(x, x**2/15.0, 'gh--' ,label='Slow')
    plt.plot(x, x**2/15.0 + 10, 'c^:' ,label='Slow + 1')
    plt.grid(True)
    plt.title('Sample Growth of a Measure')
    plt.xlabel('Samples')
    plt.ylabel('Values Measured')
    plt.legend(loc=0)
    plt.savefig('plotTest.pdf')
    plt.close()

def errorBarExample():
    x = np.arange(0,8,0.2)
    y = np.exp(-x)+0.02*np.random.randn(len(x))*(np.exp(-x)+0.5)
    z = np.exp(-x)
    er = 0.05*np.abs(np.random.randn(len(y)))*(np.exp(-x)+0.4)
    plt.errorbar(x,y,yerr=er,fmt=None,label='_nolabel_')
    plt.plot(x,y,'^',label='data')
    plt.plot(x,z,label='fit')
    plt.grid(True)
    plt.legend(loc=0)
    title = "aaa"
    plt.title(title)
    #print mpl.rcParams.keys()
    #mpl.rcParams['savefig.figsize'] = (5, 7)
    #plt.savefig.facecolor = 'b'
    plt.savefig('erb.pdf')
    plt.close()

def potentialTestPlot(potential):
    x,y=np.mgrid[-1.5:1.5:70j,-1.5:1.5:70j]
    z = potential(x, y)

    import mpl_toolkits.mplot3d
    ax=plt.subplot(111,projection='3d')
    ax.plot_surface(x,y,z,rstride=2,cstride=1,cmap=plt.cm.coolwarm,alpha=1)
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_zlabel('z')
    plt.show()
    plt.close()

def potentialTestPlot1by1(potential):
    x = np.arange(-2,2, 0.02)
    y = np.arange(-2,2,0.02)
    z=[]
    for yi in y:
        z1=[]
        for xi in x:
            z1.append(potential(xi, yi))
        z.append(z1)
    x, y = np.meshgrid(x, y)
    plt.imshow(z)
    plt.colorbar()
    plt.show()
    plt.close()

    import mpl_toolkits.mplot3d
    ax=plt.subplot(111,projection='3d')
    ax.plot_surface(x,y,z,rstride=2,cstride=1,cmap=plt.cm.coolwarm,alpha=1)
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_zlabel('z')
    plt.show()
    plt.close()

def main():
    #octave()
    def pot(x, y):
        r = np.sqrt(x**2+y**2)
        return np.tan(r*np.pi/2)**2


    def potential(x, y, pot=1, r=1, t=1):
        if abs(x)>0.7*r :
            return 0 + t
        elif (x**2 + y**2) < 0.3*r**2 :
            return 0 + t
        elif abs(y) < 0.05*r :
            return 0.5*pot + t
        else:
            return pot + t

    potentialTestPlot1by1(potential)

    #plotExample()
    #errorBarExample()
    x=np.arange(-2,2,1)
    y=[1, 2, 3]
    #x,y=np.mgrid[x,y]
    print x
    print y
    print x[0]
    print range(9)
    print len(x)

if __name__ == '__main__':
    main()

#print mpl.rcParams