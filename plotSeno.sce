// Este é um exemplo de gráfico animado utilizando seno

funcprot(0);

function str=mydisplay2D(h)
    pt = h.data;
    str=msprintf('(%0.3f, %0.3f)', pt(1), pt(2));
endfunction

x=[0:0.01:2*%pi];
fx=sin(x);

scf(1);
clf(1);
plot(x, fx);

for i=1:size(x)(2)
    e=gce();
    e=e.children;
    drawlater();
    d1=datatipCreate(e(1), [x(i), fx(i)]);
    d1.visible="off";
    d1.font_size=6;
    d1.orientation=1;
    d1.box_mode=%T;
    datatipSetDisplay(d1,"mydisplay2D");
    drawnow();
    d1.visible="on";
    d.visible="off";
    d = d1;
    sleep(33);
end

