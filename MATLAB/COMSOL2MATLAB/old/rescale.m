%rescale E and B for comparison between results in article ¡°bound states and ...¡±
midSolName='BLGevenMeshInfPotLargerAreaCalc';
eval(['AllSolVals_' midSolName 'Rescaled_eV=AllSolVals_' midSolName '_eV*(1.6e-19)/((1.05e-34)*(1e6)/(25e-9));']);
eval(['B_' midSolName 'Rescaled=sqrt(1.6e-19*B_' midSolName '/2/1.05e-34)*25e-9;']);
eval(['len_m_' midSolName 'Rescaled=len_m_' midSolName ';']);