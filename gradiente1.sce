// Implementação do gradiente descendente para f(x)=sen(x);
funcprot(0);

function str=mydisplay(h)
    pt = h.data;
    str=msprintf('(%0.3f, %0.4f)', pt(1), pt(2));
endfunction

function plota2D(x, fx, janela)
    scf(janela);
    clf(janela);
    plot(x, fx);
    
    e=gce();e=e.children;
    d=datatipCreate(e(1), 1);
    d.font_size=4;
    d.orientation=1;
    d.box_mode=%F;
        
    datatipSetDisplay(d,"mydisplay");
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
    datatipSetDisplay(d1,"mydisplay");
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

erro = 0.0001;
e = 0.01;

xm = 3*%pi/4;   // Este eh o valor inicial de x
xa = xm+erro;

d = plotaLabel2D(xm, sin(xm), 1);
sleep(500);

// Esta eh a implementação do gradient descendent para uma variável
while(abs(xm-xa)>erro)
    xa = xm;
    xm = xm - e*cos(xm); // cos(x) é o laplaciano de sen(x)
    d = plotaLabel2D(xm, sin(xm), 1, d);
end
