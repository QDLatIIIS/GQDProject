%% return the original tightbinding hamiltonian
function ham = getHamiltonian(kx, ky, Delta12, Delta23)
paras;
if nargin < 2
    Delta23 = 0;
    if nargin < 1
        Delta12 = 0;
    end
end

ham = [
    -Delta12 gamma0*f_kx_ky(kx,ky) 0 0 0 0;
    gamma0*conj(f_kx_ky(kx,ky)) -Delta12 gamma1 0 0 0;
    0 gamma1 0 gamma0*f_kx_ky(kx,ky) 0 0;
    0 0 gamma0*conj(f_kx_ky(kx,ky)) 0 gamma1 0;
    0 0 0 gamma1 Delta23 gamma0*f_kx_ky(kx,ky);
    0 0 0 0 gamma0*conj(f_kx_ky(kx,ky)) Delta23
    ];

end