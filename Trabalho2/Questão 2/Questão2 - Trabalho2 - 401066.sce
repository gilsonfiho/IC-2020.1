//2° Trabalho de Inteligência computacional

//Aluno = Francisco Gilson Pereira Almeida Filho
//Matricula = 401066

/*Questão 2:  Implemente uma rede RBF para criar uma curva que se ajuste ao conjunto de dados
do aerogerador. Plote as curvas obtidas (e mostre os valores de R2correspondentes) para diferentes 
quantidades de neurônios ocultos.*/

clear;
clc;

//Leitura dos dados do aerogerador
A = read('aerogerador.dat',-1,2); //Ajustado m=-1 para que todo o arquivo seja lido.
x = A(:,1)';
y = A(:,2)';

// Normaliza os dados do aerogerador
x = x./max(x);
y = y./max(y);

//Quantidade de neurônios ocultos
qN = 10;

//Roda 6 vezes
for h=1:6
     
    //Quantidade de amostras
    n = length(x);
    
    //Média das amostras
    ym = sum(x)/n;
    
    //Definição do sigma 
    sig = 1; 
    
    //Valor do lambida
    lambida = 0.0000000001;
    
    //Matriz dos neuronios ocultos
    B = zeros(qN,n);
    
    //Enbaralhamento das amostras
    id = grand(1,"prm", 1:n); 
    
    // Escolha de 10 valores aleatórios
    centroides = x(id(1:qN)); 
    
    //Varredura de todos os dados  e processar em cada neurônio oculto
    for i=1:n
        // Replica o x em i e faz a subtração do centroide
        sub = repmat(x(i),1,qN)-centroides; 
        
        //Realiza a norma
        for j=1:qN
            norma(j) = norm(sub(j));
        end
        //Calculo da saida dos neurônios ocultos
        B(:,i) = exp(-norma.^2/(2*sig));
        
    end
    
    //Alocação dos bides encima de cada matriz
    B = [-1*ones(1,n);B];
    
    // Geração dos valores de saída da potência
    Matriz = y*B'*(B*B'+lambida*eye(qN+1,qN+1))^(-1);
    
    //y = Xβ
    y1 = Matriz*B;
    
    //Medida dos coeficientes de determinação R2
    R2 = 1-sum(y^2-y1^2)/sum(y^2-ym^2);
    
    //Exibição do R2 de ordem 1
    disp("Quantidade de neuronios:",qN);
    disp("Valor de R2",R2);
    
    //Plota os pontos dos dados de entrada do aerogerador no formato de diamante 
    plot(x,y,'diamond');
    
    //Plote da curva em vermelho para o qN = 10
    if qN == 10 then
         plot(x,y1,'r');
    end
    //Plote da curva em azul para o qN = 12
    if qN == 12 then
         plot(x,y1,'b');
    end
    //Plote da curva em amarelo para o qN = 14
    if qN == 14 then
         plot(x,y1,'y');
    end
    //Plote da curva em preto para o qN = 16
    if qN == 16 then
         plot(x,y1,'k');
    end
    //Plote da curva em verde para o qN = 18
    if qN == 18 then
         plot(x,y1,'g');
    end
    //Plote da curva em branco para o qN = 20
    if qN == 20 then
         plot(x,y1,'w');
    end
    
    //Espera 1 segundo
    sleep(1000);
    //Incrimenta o qN em +2
    qN = qN + 2;
    
end
   




