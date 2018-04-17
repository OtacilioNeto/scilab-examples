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
// Esse eh o Jacobiano particionado. 
// x eh o ponto onde se está fazendo o cálculo
// teta eh o vetor de parâmetros
// lenghtA eh o tamanho do vetor de parâmetros A, o resto fica para B
function [A, B] = J(x, teta, lenghtA)
    A = zeros(size(x, 1), lenghtA);
    B = zeros(size(x, 1), size(teta, 1)-lenghtA);
    // Lembre-se que eh o calculo do Jacobiano da funcao de erro
    for i=1:size(x, 1)
        A(i, 1) = -x(i)/(teta(2)+x(i));
        B(i, 1) = teta(1)*x(i)/((teta(2)+x(i))^2);
    end
endfunction

function [teta, resto, Ea, Eb, Eab, iteracoes]=PartLevenbergMarquardt(pY, X, teta, E, lambda, moduloErro)
    iteracoes = 0;
    
    terminou = %F;
    invE = inv(E);
    while(terminou == %F)
        [A B] = J(X, teta, 1);      // Calcula o Jacobiano
        e = Z(pY, X, teta);         // Calcula o erro
        J1 = [A B];
        
        U = A'*invE*A;
        V = B'*invE*B;
        W = A'*invE*B;
        eA = A'*invE*e;
        eB = B'*invE*e;
        
        Ua = U+lambda*eye(size(U, 1), size(U,1));
        Va = V+lambda*eye(size(V, 1), size(V,1));
        
        invVa = inv(Va);
        Y  = W*invVa;

        da = inv(Ua-Y*W')*(eA-Y*eB);
        db = invVa*(eB-W'*da);
        
        oldteta = teta;     // Salva o conjunto de parametros
        teta = teta -[da db]';
        e2 = Z(pY, X, teta); // Calcula o novo valor do erro
        if (norm(e2) <= norm(e)) then
            lambda = lambda / 10;
        else
            teta = oldteta;
            lambda = lambda * 10;
        end
        iteracoes = iteracoes + 1;
        if(norm(e2-e)<moduloErro) then
            terminou = %T;
        end
    end
    
    resto = [da db]';
    
    Y  = W*inv(V);
    Ea = pinv(U-Y*W');
    Eb = Y'*Ea*Y+inv(V);
    Eab = -Ea*Y;
endfunction

Y=[0.050 0.127 0.094 0.2122 0.2729 0.2665 0.3317]'; // Valores medidos
X=[0.038 0.194 0.425 0.626  1.253  2.500  3.740 ]'; // Valores de entradas para 
                                                    // a função de ajuste
covariancia = eye(size(Y,1), size(Y,1));
tetaI=[9 2]';               // Valores iniciais dos parâmetros
residuo = 0.0000000005;         // Enquanto o incremento for maior que isso continue 
                                // a otimização

// A função é do tipo           AX
//                    f(x) = --------
//                           B + X   

// Onde A e B sao os parametros que se quer ajustar e valem inicialmente
// A = tetaI(1); B = tetaI(2)
scf(1);
clf(1);
scatter(X, Y);
[teta, residuo, Ea, Eb, Eab, iteracoes] = PartLevenbergMarquardt(Y, X, tetaI, covariancia, 100, residuo);

mprintf("\nValores iniciais dos parametros:\n%f\n%f\n", tetaI(1), tetaI(2));
mprintf("\nValores finais dos parametros:\n%f covariancia %f;\n%f covariancia %f;\ncovariancia cruzada %f\n(%d iteracoes) (residuo = %0.12f)\n", teta(1), Ea, teta(2), Eb, Eab, iteracoes, residuo);

X1=[0:0.1:max(X)+1];
Y1=zeros(X1);
for i=1:size(X1)(2)
    Y1(i) = teta(1)*X1(i) / (teta(2)+X1(i));
end

plot2d(X1, Y1);

xtitle("Método Partitioned Levenberg-Marquardt");
