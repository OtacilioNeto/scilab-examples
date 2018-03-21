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

function [d,  e, f]=plotaLabel3D(x, y, fx, janela, varargin)
    [lhs,rhs]=argn(0);

    scf(janela);
    f1=scatter3([x x], [y y], [fx fx], 400, "red", "fill", "*");
    param3d1([x x], [y y], [fx fx+5]);
    e1 = gce();
    d1=datatipCreate(e1, 2);
    d1.visible="off";
    d1.font_size=4;
    d1.orientation=1;
    d1.box_mode=%T;
    datatipSetDisplay(d1, "mydisplay3D");
    drawnow();
    d1.visible="on";
    if rhs>=7 then
        d = varargin(1);
        e = varargin(2);
        f = varargin(3);
        d.visible = "off";
        e.visible = "off";
        f.visible = "off";
    end
    d = d1;
    e = e1;
    f = f1;
endfunction

x=[0:0.1:2*%pi];
y=[0:0.1:2*%pi];
fxy=sin(x')*cos(y);

scf(1);
clf(1);
plot3d(x, y, fxy);

erro = 0.0001;
ep = 0.1;

xm = 3.9*%pi/4;   // Este eh o valor inicial de x
ym = 3.9*%pi/4;   // Este eh o valor inicial de y
xa = xm+erro;
ya = ym+erro;

[d, e, f] = plotaLabel3D(xm, ym, sin(xm)*cos(ym), 1);
sleep(500);

/// Esta eh a implementação do gradient descendent para uma variável
while(abs(xm-xa)>erro && abs(ym-ya)>erro)
    xa = xm;
    ya = ym;
    xm = xm - ep*cos(xm)*cos(ym);    // Lembre-se que estas duas linhas correspondem ao laplaciano de sen(x)cos(y)
    ym = ym - ep*sin(xm)*(-sin(ym));
    [d, e, f] = plotaLabel3D(xm, ym, sin(xm)*cos(ym), 1, d, e, f);
end

