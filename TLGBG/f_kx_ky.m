%% return the value f in the hamiltonian
function f = f_kx_ky(kx, ky)
paras;
f = exp(1i*kx*a0/sqrt(3))+2*exp(-1i*kx*a0/(2*sqrt(3)))*cos(ky*a0/2);
end