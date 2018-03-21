funcprot(0)
clc
function R=calc_r(Y, X, B)  // Calcula o erro (analogia com erro de reprojeção)
    R=[];
    for i=1:size(Y, 1)
        R(i) = Y(i) - X(i)*B(1)/(B(2)+X(i));
    end
endfunction

function rJ=calc_J(X, B)    // Monta a matriz jacobiano. Calcula uma linha por 
                            // por vez. Cada linha tem dois elementos porque o
                            // vetor de estado tem dois elementos
    rJ=[];
    for i=1:size(X, 1)
        rJ(i,:) = [-X(i)/(B(2)+X(i)) B(1)*X(i)/(B(2)+X(i))^2];
    end
endfunction

function BS1=B_s_1(Y, X, B)
    r = calc_r(Y, X, B);
    J = calc_J(X, B);
    BS1 = B - inv(J'*J)*J'*r;
endfunction

Y = [0.050 0.127 0.094 0.2122 0.2729 0.2665 0.3317]';
X = [0.038 0.194 0.425 0.6260 1.2530 2.5000 3.7400]';
B = [0.9 0.2]'; //B é o vetor de estados
printf("\nValores iniciais");
disp(B);
for i=1:10
    B = B_s_1(Y, X, B);
end
printf("Valores ajustados");
disp(B);
