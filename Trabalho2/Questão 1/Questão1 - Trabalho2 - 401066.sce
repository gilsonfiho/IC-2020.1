//2° Trabalho de Inteligência computacional

//Aluno = Francisco Gilson Pereira Almeida Filho
//Matricula = 401066

/*Questão 1: Implemente um neurônio Perceptron com valores de pesos inicialmente aleatórios
para revolver o problema do AND com duas variáveis. O programa deverá plotar os pontos da 
tabela-verdade e a reta de separação obtida.*/

clear;

//Entradas e saidas da porta and, a primeira coluna é o bias(b)
dados = [-1 0 0 0
         -1 0 1 0
         -1 1 0 0
         -1 1 1 1];
         
//Matriz de pesos      
w = [];
//Valores de pesos inicialmente aleatórios
for i=1:3 
    w(i)=rand();
end

//Ponteiro responsável por fazer a varredura na matriz w
ponteiro = 1;

//Roda 10 vezes 
for i=1:40
    
    x = dados(ponteiro,1:3);
    tar=dados(ponteiro,4);
    
    //Somatório 
    net = x*w;
    //Passando pela função de ativação
    if net>=0 then
        net=1;
    else
        net=0;
    end
    
    //Erro da rede neural
    erro = tar-net;
    
    //Processo de aprendizagem 
    //Equação de aprendiz fornecida no slide
    //Usei 0.5 na taxa de aprendizagem 
    for i = 1:3
        w(i) = w(i)+0.5*erro*x(i);  
    end
    
    //Passa para a próxima linha da matriz 
    ponteiro=ponteiro+1;
    
    //Se for maior que 4 volta para  a linha 1
    if ponteiro>4 then
        ponteiro = 1;
    end
    
    //Carregando informações no console
    disp('---------------------');
    disp('Pesos:');
    disp(w)
    disp('Entrada:');
    disp(x);
    disp('Alvo:');
    disp(tar);
    disp('net:');
    disp(net);

    //Espera 1 segundo 
    sleep(1000);

end

//Plote dos pontos da tabela-verdade
plot(0,0,'*');
plot(0,1,'*');
plot(1,0,'*');
plot(1,1,'*');

//Mapeia pontos de 0 a 2 em 200 subdivisões
x1 = linspace(0,2,200);
//Equação da reta fornecida no slide
x2 = -(w(2)/w(3))*x1 + w(1)/w(3);

//Plote da reta de separação;
plot(x1,x2,'b');
