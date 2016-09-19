%delete repeated E
Edeleted = E_m_0;
Bdeleted = B_m_0;
for i = 1:length(Edeleted)
    if Edeleted(i)==0
        continue
    end
    for j = i:length(Edeleted)
        if Edeleted(i)==Edeleted(j)
            Edeleted(j)=0;
            Bdeleted(j)=0;
        end
    end
end