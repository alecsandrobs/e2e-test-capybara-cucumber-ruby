# language: pt

@CalcularAposentadoria
Funcionalidade: Calcular investimento para aposentadoria privada
  Como usuário eu desejo calcular o valor necessário para investir para uma possível aposentadoria privada.

  # @CalcularAposentadoriaValido
  Esquema do Cenário: Calcular aposentadoria válido
    Dado o usuário acessou o ambiente para calcular a aposentadoria
    Quando digitar "<valor>" no campo valor desejado
    E digitar "<anos>" no campo anos de contribuição
    E digitar "<taxa>" no campo taxa
    E clicar no botão com o texto "Calcular"
    Então deveria exibir "Investimento mensal: R$<investimento>" no valor a ser investido ao mês

    Exemplos:
      | valor    | anos | taxa | investimento |
      | 3475,00  | 15   | 6    | 604,49       |
      | 4526,48  | 20   | 6    | 498,22       |
      | 10000,00 | 35   | 6    | 363,35       |
      | 15000,00 | 35   | 3,99 | 521,89       |
      | 15000,00 | 15   | 0,07 | 1.011,96     |
