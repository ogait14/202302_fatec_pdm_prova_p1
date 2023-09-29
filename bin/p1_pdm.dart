import 'dart:math'; //import da biblioteca math para o uso do objeto random
import 'dart:io'; //import da biblioteca io para permitir a entrada e captura de dados do usuário

void main() {
  // Imprime uma linha de asteriscos para fins de formatação.
  print("\n***********************************************************");
  // Imprime uma mensagem de boas-vindas no console.
  print('---->Bem-vindo ao Jogo!<----\n');
  // Declara uma variável booleana para controlar se o jogo deve ser jogado novamente.
  bool novoJogo = true;

  // Inicia um loop que continuará executando o jogo enquanto jogarNovamente for verdadeiro.
  while (novoJogo) {
    // Declara variáveis para rastrear vitorias, empates, e uso do dado mágico.
    int vit_Us = 0;
    int vitoriasComputador = 0;
    int empates = 0;
    int dadoMagico = 0;

    // Solicita ao usuário a quantidade de rodadas que deseja jogar.
    int rodadas = int.parse(leitura('Quantas rodadas você deseja jogar? '));

    // Cria uma lista de números representando as faces do dado.
    List<int> numerosDado = [1, 2, 3, 4, 5, 6];
    // Imprime uma linha de asteriscos para fins de formatação.
    print("***********************************************************");

    // Declara listas para armazenar resultados do usuário, computador e pontos de cada rodada.

    List<List<int>> dadosUsuario =
        []; // Armazena resultados dos dados do usuário em cada rodada.
    List<List<int>> dadosComputador =
        []; // Armazena resultados dos dados do computador em cada rodada.
    List<int> pontosRodadaUsuario = [];
    List<int> pontosRodadaComputador = [];

    // Loop que executa o jogo para cada rodada.
    for (int i = 1; i <= rodadas; i++) {
      // Imprime o número da rodada.
      print('\n--- Rodada $i ---\n');
      // Rola dados para o usuário e o computador.
      List<int> dadosUsuarioRodada = rolarDados(numerosDado);
      List<int> dadosComputadorRodada = rolarDados(numerosDado);

      // Armazena os resultados dos dados nas listas mais internas de List<List<int>> dadosUsuario.
      dadosUsuario.add(dadosUsuarioRodada);
      dadosComputador.add(dadosComputadorRodada);

      // Calcula a soma dos pontos do usuário e do computador.
      int somaPontosUsuario = dadosUsuarioRodada.reduce((a, b) =>
          a +
          b); // método reduce, nesse caso, pega todos os números da lista e os soma
      //(em uma lista do tipo [a,b,], retorna a+b)
      int somaPontosComputador = dadosComputadorRodada.reduce((a, b) => a + b);
      //note que o incremento é feito de dois em dois, assim, numa lista [a, b, c, d], temos a + b, seguido de (a+b)+c, seguido de (a+b+c) + d

      // Armazena os pontos da rodada em listas.
      pontosRodadaUsuario.add(somaPontosUsuario);
      pontosRodadaComputador.add(somaPontosComputador);

      // Imprime os resultados dos dados.
      print(
          '\nResultados dos dados do usuário: $dadosUsuarioRodada (Total: $somaPontosUsuario)');
      print(
          'Resultados dos dados do computador: $dadosComputadorRodada (Total: $somaPontosComputador)');

      // Verifica se o dado mágico pode ser usado e o aplica.
      if (dadoMagico < 1) {
        if (leitura('\nDeseja usar o dado mágico? (s/n): ').toLowerCase() ==
            's') {
          double teste = Random()
              .nextDouble(); // o uso do objeto random associado com double permite escolher aleatóriamente em um número entre 0 e 1
          //melhor que usar um int entre 0 ou 1 pois há uma variedade maior de números.
          if (teste < 0.5) {
            //o if faz o teste do número escolhido, havendo 50% de chance de ser < ou > que 0.5
            somaPontosUsuario = (somaPontosUsuario / 2)
                .round(); //round arredonda o número da divisão para o inteiro mais próximo (Ex. de 0,5 até 0,999... arredonda para 1)
            print(
                '\nA pontuação total do usuário foi reduzida pela metade! Nova pontuação: $somaPontosUsuario');
          } else {
            somaPontosUsuario = somaPontosUsuario * 2;
            print(
                '\nA pontuação total do usuário foi dobrada! Nova pontuação: $somaPontosUsuario');
          }
          // Incrementa o contador do dado mágico para limitar seu uso.
          dadoMagico++;
        }
      }

      // Determina o vencedor da rodada e atualiza as estatísticas.
      if (somaPontosUsuario > somaPontosComputador) {
        print('\nVocê venceu a rodada!');
        vit_Us++;
      } else if (somaPontosComputador > somaPontosUsuario) {
        print('\nO computador venceu a rodada!');
        vitoriasComputador++;
      } else {
        print('\nEmpate na rodada!');
        empates++;
      }
      // Imprime uma linha para fins de formatação.
      print('---------------------------------------------------------');
    }
    // Imprime resultados finais do jogo.
    print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    print('\n--- Resultados finais ---');
    print('Vitórias do usuário: $vit_Us');
    print('Vitórias do computador: $vitoriasComputador');
    print('Empates: $empates');

    // Determina o vencedor geral do jogo.
    if (vit_Us > vitoriasComputador) {
      print('\nParabéns, você venceu o jogo!');
    } else if (vitoriasComputador > vit_Us) {
      print('\nO computador venceu o jogo!');
    } else {
      print('\nO jogo terminou em empate!');
    }

    // Imprime os resultados detalhados de cada rodada.
    for (int i = 0; i < rodadas; i++) {
      print('\n--- Rodada ${i + 1} ---');
      print('Resultados dos dados do usuário: ${dadosUsuario[i]} ');
      print('Resultados dos dados do computador: ${dadosComputador[i]} ');
      print(
          '-----------------------------------------------------------------');
    }
    // Imprime uma linha para fins de formatação.
    print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');

    // Pergunta ao jogador se deseja jogar novamente.
    String novoJogoInput =
        leitura('\nDeseja jogar novamente? (s/n): ').toLowerCase();
    novoJogo =
        novoJogoInput == 's'; //verifica se o que foi digitado é igual a 's'.
    //Caso sim, jogarNovamente continua como true. Caso qualquer outra coisa seja digitada, jogarNovamente recebe false
  }
  // Imprime uma linha de asteriscos para fins de formatação.
  print("***********************************************************");
  // Imprime uma mensagem de agradecimento e encerra o programa.
  print('Obrigado por jogar!\n');
}

//função rolar dados que recebe uma lista de inteiros, no caso a lista de números possíveis no dado
//e retorna uma lista de números inteiros composta de 3 numeros
List<int> rolarDados(List<int> numerosDado) {
  Random random = Random();
  return [
    //tres rolagens para tres numeros aleatórios entre 6 possiveis
    numerosDado[random.nextInt(6)],
    numerosDado[random.nextInt(6)],
    numerosDado[random.nextInt(6)]
  ];
}

//função leitura para tornar o codigo menos verboso
//recebe o prompt da mensagem que se quer mostra no prompt pro usuário
String leitura(String prompt) {
  print(prompt);
  //faz a captura do que o usuário digitar e retorna a entrada do usuário,
  //enfatizando para o compilador que o resultado não é nulo pelo !
  return stdin.readLineSync()!;
}
