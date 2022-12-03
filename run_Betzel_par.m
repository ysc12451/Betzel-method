core = 4;
p = parpool(core);
p.IdleTimeout = 100;

data = zeros(1,5);

parfor i = 1:5
    a = test(i);
    data(i) = a;
end

delete(p);

function a = test(i)
    a = i*2;
end