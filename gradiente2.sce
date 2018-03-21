// Implementação do gradiente descendente para f(x, y)=sen(x)cos(y);
funcprot(0);

function str=mydisplay3D(h)
    pt = h.data;
    str=msprintf('(%0.3f, %0.3f, %0.4f)', pt(1), pt(2), pt(3));
endfunction

function plota3D(x, y, fx, janela)
    scf(janela);
    clf(janela);
    plot3d(x, y, fx);
    
    e=gce();e=e.children;
    d=datatipCreate(e(1), 1);
    d.font_size=4;
    d.orientation=1;
    d.box_mode=%F;
        
    datatipSetDisplay(d,"mydisplay3D");
endfunction

function [d]=plotaLabel3D(x, y, fx, janela, varargin)
    [lhs,rhs]=argn(0);

    scf(janela);
    e=gce();
    drawlater();
    d1=datatipCreate(e, [x, y, fx]);
    d1.visible="off";
    d1.font_size=6;
    d1.orientation=1;
    d1.box_mode=%T;
    datatipSetDisplay(d1,"mydisplay3D");
    drawnow();
    d1.visible="on";
    if rhs>=5 then
        d = varargin(1);
        d.visible="off";
    end
    d = d1;
endfunction

x=[0:0.1:2*%pi];
y=[0:0.1:2*%pi];
fxy=sin(x')*cos(y);

scf(1);
clf(1);
plot3d(x, y, fxy);

erro = 0.0001;
e = 0.1;

xm = 3*%pi/4;   // Este eh o valor inicial de x
ym = 3*%pi/4;   // Este eh o valor inicial de y
xa = xm+erro;
ya = ym+erro;

d = plotaLabel3D(xm, ym, sin(xm)*cos(ym), 1);
// sleep(500);

/* // Esta eh a implementação do gradient descendent para uma variável
while(abs(xm-xa)>erro)
    xa = xm;
    xm = xm - e*cos(xm); // cos(x) é o laplaciano de sen(x)
    d = plotaLabel2D(xm, sin(xm), 1, d);
end
*/
