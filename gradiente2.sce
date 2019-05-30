// Implementação do gradiente descendente para f(x, y)=sen(x)cos(y);
funcprot(0);

function str=mydisplay3D(h)
    pt = h.data;
    // O -5 eh para mostrar o label correto
    str=msprintf('(%0.3f, %0.3f, %0.4f)', pt(1), pt(2), pt(3)-5);
endfunction

function [d,  e, f]=plotaLabel3D(x, y, fx, janela, varargin)
    [lhs,rhs]=argn(0);

    scf(janela);
    f1=scatter3([x x], [y y], [fx fx], 400, "red", "fill", "*");
    // O +5 eh para posicionamento do label
    param3d1([x x], [y y], [fx fx+5]);
    e1 = gce();
    drawlater();
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

erro = 0.00001;
p = 0.1;

xi = %pi/2+0.1; // Este eh o valor inicial de x
yi = %pi/2+0.1; // Este eh o valor inicial de y

xi_1 = xi-erro;
yi_1 = yi-erro;


[d, e, f] = plotaLabel3D(xi, yi, sin(xi)*cos(yi), 1);

/// Esta eh a implementação do gradient descendent para uma variável
while(abs(xi-xi_1)>=erro || abs(yi-yi_1)>=erro)
    [d, e, f] = plotaLabel3D(xi, yi, sin(xi)*cos(yi), 1, d, e, f);    
    xi_1 = xi;
    yi_1 = yi;
    xi = xi_1 - p*cos(xi_1)*cos(yi_1);    // Lembre-se que estas duas linhas correspondem ao gradiente de sen(x)cos(y)
    yi = yi_1 - p*sin(xi_1)*(-sin(yi_1));
end

