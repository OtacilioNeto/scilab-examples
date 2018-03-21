// Solucao do exemplo https://pt.wikipedia.org/wiki/Algoritmo_de_Gauss-Newton#Exemplo

funcprot(0)
clc

// Calcula Z =[ y - f(x) ]
function z1 = Z(y, x, teta)
    z1 = zeros(size(y,1));
    
    for i=1:size(y, 1)
        z1(i) = y(i) - teta(1)*x(i)/(teta(2)+x(i));
    end
endfunction

// Calcula o Jacobiano
function [J1] = J(x, teta)
    J1= zeros(size(x, 1), size(teta, 1));    
    // Lembre que cada linha eh uma derivada parcial com relação a uma variável
    for i=1:size(x, 1)
        J1(i, 1) = -x(i)/(teta(2)+x(i));
        J1(i, 2) = teta(1)*x(i)/((teta(2)+x(i))*(teta(2)+x(i)))
    end
endfunction

function lteta=GaussNewtonI(Y, X, teta, n)
    lteta = teta;
    for i=1:n
        Z1 = Z(Y, X, lteta);
        J1 = J(X, lteta);
        lteta = lteta - inv(J1'*J1)*J1'*Z1;
    end
endfunction

function [teta, resto, iteracoes]=GaussNewton(Y, X, teta, residuo)
    iteracoes = 0;
    Z1 = Z(Y, X, teta);
    J1 = J(X, teta);
    resto = inv(J1'*J1)*J1'*Z1;
    while(abs(resto)>residuo)
        iteracoes = iteracoes + 1;
        teta = teta - resto;
        
        Z1 = Z(Y, X, teta);
        J1 = J(X, teta);
        resto = inv(J1'*J1)*J1'*Z1;
    end
endfunction

Y=[0.050 0.127 0.094 0.2122 0.2729 0.2665 0.3317]'; // Valores medidos
X=[0.038 0.194 0.425 0.626  1.253  2.500  3.740]';  // Valores de entradas para 
                                                    // a função de ajuste
tetaI=[0.9 0.2]';               // Valores iniciais dos parâmetros
iteracoes=10;                   // NUmero de iterações
residuo = 0.0000000005;         // Enquanto o incremento for maior que isso continue 
                                // a otimização

// A função é do tipo           AX
//                    f(x) = --------
//                           B + X   

// Onde A e B sao os parametros que se quer ajustar e valem inicialmente
// A = tetaI(1); B = tetaI(2)

scatter(X, Y);
[teta, residuo, iteracoes] = GaussNewton(Y, X, tetaI, residuo);

mprintf("\nValores iniciais dos parametros: %f %f\n", tetaI(1), tetaI(2));
mprintf("Valores finais dos parametros: %f %f (%d iteracoes) (residuo = %0.12f)\n", teta(1), teta(2), iteracoes, residuo);

X1=[0:0.1:max(X)+1];
Y1=zeros(X1);
for i=1:size(X1)(2)
    Y1(i) = teta(1)*X1(i) / (teta(2)+X1(i));
end

plot2d(X1, Y1);

xtitle("Método Gauss Newton");