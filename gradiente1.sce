// Implementação do gradiente descendente para f(x)=sen(x);
funcprot(0);

function str=mydisplay2D(h)
    pt = h.data;
    str=msprintf('(%0.3f, %0.4f)', pt(1), pt(2));
endfunction

function [d]=plotaLabel2D(x, fx, janela, varargin)
    [lhs,rhs]=argn(0);

    scf(janela);
    e=gce();
    e=e.children;
    drawlater();
    d1=datatipCreate(e(1), [x, fx]);
    d1.visible="off";
    d1.font_size=6;
    d1.orientation=1;
    d1.box_mode=%T;
    datatipSetDisplay(d1,"mydisplay2D");
    drawnow();
    d1.visible="on";
    if rhs>=4 then
        d = varargin(1);
        d.visible="off";
    end
    d = d1;
endfunction

x=[0:0.01:2*%pi];
fx=sin(x);

scf(1);
clf(1);
plot(x, fx);

erro = 0.00001;
e = 0.1;

xm = %pi/2+0.01;   // Este eh o valor inicial de x

d = plotaLabel2D(xm, sin(xm), 1);

// Esta eh a implementação do gradient descendent para uma variável
while(%T)
    d = plotaLabel2D(xm, sin(xm), 1, d);
    xa = xm;
    xm = xm - e*cos(xm); // cos(x) é o laplaciano de sen(x)
    if(abs(xm-xa)<erro)then
        break;
    end
end
