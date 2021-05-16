      # language: pt

      @CalcularSalario
      Funcionalidade: Calcular os impostos e o salário líquido

      Como usuário eu desejo calcular os impostos e deduções realizadas no meu salário e saber o que foi gasto de INSS, IRRF e ao final mostrar o meu salário líquido.

      Contexto: Background name
      Dado o usuário acessou o ambiente para calcular salário líquido e impostos

      @CalcularSalarioValido
      Esquema do Cenário: Calcular salário válido
      Quando digitar "<salario>" no campo salário bruto
      E digitar "<dependentes>" no campo dependentes
      E digitar "<descontos>" no campo descontos
      E clicar no botão com o texto "Calcular"
      E aguardar 1 segundos
      Então deveria exibir "Salário bruto: R$<salarioBruto>" no valor do salário bruto
      E deveria exibir "INSS: R$<inss> (<inssPerc>%)" no valor do INSS
      E deveria exibir "IRRF: R$<irrf> (<irrfPerc>%)" no valor do IRRF
      E deveria exibir "Salário sem impostos: R$<salarioSemImpostos>" no valor do salário sem impostos
      E deveria exibir "Salário líquido: R$<salarioLiquido>" no valor do salário líquido

      Exemplos:
      | salario | dependentes | descontos | salarioBruto | inss   | inssPerc | irrf   | irrfPerc | descontoEmpresa | salarioSemImpostos | salarioLiquido |
      | 4526,48 | 0           | 112,38    | 4.526,48     | 492,66 | 10,88    | 271,48 | 22,50    | 669,92          | 3.762,34           | 3.649,96       |
      | 3475,00 | 0           | 216,50    | 3.475,00     | 345,45 | 9,94     | 114,63 | 15,00    | 514,30          | 3.014,92           | 2.798,42       |

      @CalcularSalarioInssValoresLimite
      Esquema do Cenário: Calcular INSS valores limites
      E digitar "<salario>" no campo salário bruto
      E clicar no botão com o texto "Calcular"
      E aguardar 1 segundos
      Então deveria exibir "INSS: R$<inss> (<inssPerc>%)" no valor do INSS
      E deveria exibir "Salário líquido: R$<salarioLiquido>" no valor do salário líquido

      Exemplos:
      | salario  | inss   | inssPerc | salarioLiquido |
      # | -9999,99 | 0,00   | 0,00     | -9.999,99      |
      # | 0,00     | 0,00   | 0,00     | 0,00           |
      | 1044,99  | 78,37  | 7,50     | 966,62         |
      | 1045,00  | 78,38  | 7,50     | 966,63         |
      | 1045,01  | 78,37  | 7,50     | 966,64         |
      | 2089,59  | 172,38 | 8,25     | 1.916,22       |
      | 2089,60  | 172,38 | 8,25     | 1.916,22       |
      | 2089,61  | 172,39 | 8,25     | 1.916,23       |
      | 3134,39  | 297,77 | 9,50     | 2.765,93       |
      | 3134,40  | 297,77 | 9,50     | 2.765,94       |
      | 3134,41  | 297,77 | 9,50     | 2.765,95       |
      | 6101,05  | 713,10 | 11,69    | 4.775,63       |
      | 6101,06  | 713,10 | 11,69    | 4.775,63       |
      | 7000,00  | 713,08 | 10,19    | 5.427,38       |
      | 27999,99 | 713,08 | 2,55     | 20.652,37      |

      @CalcularSalarioIrrfValoresLimite
      Esquema do Cenário: Calcular IRRF valores limites
      Quando digitar "<salario>" no campo salário bruto
      E digitar "<dependentes>" no campo dependentes
      E clicar no botão com o texto "Calcular"
      E aguardar 1 segundos
      E deveria exibir "IRRF: R$<irrf> (<irrfPerc>%)" no valor do IRRF
      E deveria exibir "Salário líquido: R$<salarioLiquido>" no valor do salário líquido

      Exemplos:
      | salario  | dependentes | irrf     | irrfPerc | salarioLiquido |
      # | -9999,99 | 0,00        | 0,00     | 0,00     | -9.999,99      |
      # | 0,00     | 0,00        | 0,00     | 0,00     | 0,00           |
      | 1903,98  | 0,00        | 0,00     | 0,00     | 1.748,30       |
      | 1903,99  | 0,00        | 0,00     | 0,00     | 1.748,31       |
      | 1904,00  | 0,00        | 0,00     | 0,00     | 1.748,32       |
      | 2826,64  | 0,00        | 49,64    | 7,50     | 2.516,17       |
      | 2826,65  | 0,00        | 49,64    | 7,50     | 2.516,18       |
      | 2826,66  | 0,00        | 49,64    | 7,50     | 2.516,18       |
      | 3751,04  | 0,00        | 150,24   | 15,00    | 3.216,70       |
      | 3751,05  | 0,00        | 150,24   | 15,00    | 3.216,71       |
      | 3751,06  | 0,00        | 150,24   | 15,00    | 3.216,72       |
      | 3751,07  | 0,00        | 150,25   | 15,00    | 3.216,72       |
      | 4664,67  | 0,00        | 298,22   | 22,50    | 3.854,45       |
      | 4664,68  | 0,00        | 298,22   | 22,50    | 3.854,45       |
      | 4664,69  | 0,00        | 298,22   | 22,50    | 3.854,46       |
      | 4664,70  | 0,00        | 298,23   | 22,50    | 3.854,47       |
      | 7000,00  | 0,00        | 859,54   | 27,50    | 5.427,38       |
      | 27999,99 | 0,00        | 6.634,54 | 27,50    | 20.652,37      |
      | 2827,00  | 1           | 35,44    | 7,50     | 2.530,68       |
      | 2827,00  | 2           | 21,22    | 7,50     | 2.544,90       |
      | 2827,00  | 3           | 7,00     | 7,50     | 2.559,12       |
      | 2827,00  | 4           | 0,00     | 0,00     | 2.566,12       |
