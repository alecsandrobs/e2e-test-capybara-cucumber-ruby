@Emprestimos
Feature: Cadastro de empréstimos

  Background: Prepara base
    Given que não existem empréstimos
    And que não existem pessoas
    And que existem pessoas
      | nome                                 | telefone         | email                         |
      | Magnesia Bisurada do Patrocinio      | (88) 9 9898-8989 | magnesia.patrocinio@mail.com  |
      | Manoel Sovaco de Gambar              | (55) 9 9797-7979 | manoel.gambar@gamba.com.br    |
      | Marciano Verdinho das Antenas Longas | 964785123        | marciano.longas@etmail.com.mt |
      | Maria Constança Dores Pança          | 57987654321      | maria.panca@barriga.com.br    |
      | Maria Cristina do Pinto              | (78) 99988-9595  | maria.pinto@email.com         |
      | Sete Chagas de Jesus e Salve Patria  | 977777777        | setechagas.patria@email.com   |

  @EmprestimosCadastro
  Scenario Outline: Cadastrando empréstimo
    And o usuário acessou o menu empréstimos
    When clicar no botão com o texto "Empréstimo"
    And selecionar "<tipo>" no campo tipo do empréstimo
    And digitar "<dataEmprestimo>" no campo data do empréstimo
    And selecionar "<situacao>" no campo situação do empréstimo
    And digitar "<dataDevolucao>" no campo data de devolução do empréstimo
    And selecionar "<pessoa>" no campo pessoa do empréstimo
    And digitar "<observacoes>" no campo observações do empréstimo
    And adicionar os itens no empréstimos "<itensAdicionar>"
    Then deveria existir <itensQuantidade> itens do empréstimo
    And deveria exibir "<itens>" na lista de itens do empréstimo
    And deveria exibir "<itens>" na linha 1 da lista de itens do empréstimo
    And aguardar 1 segundo
    When clicar no botão com o texto "Salvar"
    Then deveria exibir a mensagem "Empréstimo inserido com sucesso"
    And aguardar 3 segundos
    Then deveria existir <emprestimosQuantidade> empréstimos
    And deveria exibir "<emprestimo>" na lista de empréstimos
    And deveria exibir "<emprestimo>" na linha <linhaEmprestimo> da lista de empréstimos
    When clicar no botão com o título "Editar" do empréstimo "<emprestimo>"
    And aguardar 1 segundo
    And deveria exibir "<tipo>" no campo tipo do empréstimo
    And deveria exibir "<dataEmprestimo>" no campo data do empréstimo
    And deveria exibir "<situacao>" no campo situação do empréstimo
    And deveria exibir "<dataDevolucao>" no campo data de devolução do empréstimo
    And deveria exibir "<pessoa>" no campo pessoa do empréstimo
    And deveria exibir "<observacoes>" no campo observações do empréstimo
    Then deveria existir <itensQuantidade> itens do empréstimo
    And deveria exibir "<itens>" na lista de itens do empréstimo
    And deveria exibir "<itens>" na linha 1 da lista de itens do empréstimo
    And deveria exibir "<itensAdicionar>" nos campos itens no empréstimos
    And aguardar 1 segundo
    And clicar no botão com o texto "Cancelar"
    And aguardar 1 segundo

    Examples:
      | tipo      | dataEmprestimo | situacao   | dataDevolucao | pessoa                  | observacoes                                          | itensAdicionar                                                                                                                                                                                                                                                         | itensQuantidade | itens                                      | emprestimosQuantidade | emprestimo                    | linhaEmprestimo |
      | Concedido | 16/03/2021     | Emprestado | 22/03/2021    | Maria Cristina do Pinto | Empréstimo concedido no domingo tem custo adicional. | [{"codigo":"1","descricao":"Caixa de som JBL Flip 4","quantidade":"1","preco":"20"},{"codigo":"2","descricao":"Fone de ouvido bluetooth JBL","quantidade":"1","preco":"15"},{"codigo":"3","descricao":"Kit mouse e teclado sem fio","quantidade":"2","preco":"12.25"}] | 3               | 1 Caixa de som JBL Flip 4 1,00 20,00 20,00 | 1                     | 00:00 Maria Cristina do Pinto | 1               |
      | Recebido  | 01/12/2020     | Devolvido  | 31/01/2021    | Manoel Sovaco de Gambar | Empréstimo recebido para devolução no mesmo dia.     | [{"codigo":"1","descricao":"Apple Ipad 6","quantidade":"1","preco":"35.5"},{"codigo":"2","descricao":"Smartband","quantidade":"1","preco":"4.5"}]                                                                                                                      | 2               | 1 Apple Ipad 6 1,00 35,50 35,50            | 1                     | 00:00 Manoel Sovaco de Gambar | 1               |

  @EmprestimosEdicao
  Scenario Outline: Editando empréstimo
    Given que existem empréstimos
      | tipo      | dataEmprestimo           | situacao   | dataDevolucao            | pessoa                               | observacoes                           | itens                                                                     |
      | CONCEDIDO | 2019-06-03T03:00:00.000Z | EMPRESTADO | 2019-06-07T03:00:00.000Z | Marciano Verdinho das Antenas Longas | Empréstimo concedido no dia seguinte. | [{"codigo":"1","descricao":"Laptop Samsung","quantidade":1,"valor":35.5}] |
    And o usuário acessou o menu empréstimos
    When clicar no botão com o título "Editar" do empréstimo "<emprestimoEditar>"
    And aguardar 1 segundo
    # And DEVE SER CRIADO STEPS PARA EDITAR O EMPRÉSTIMO
    # And aguardar 15 segundos
    # And DEVE SER CRIADO STEPS PARA EDITAR O EMPRÉSTIMO
    And clicar no botão com o texto "Salvar"
    And aguardar 1 segundo
    Then deveria exibir a mensagem "Empréstimo atualizado com sucesso"

    Examples:
      | emprestimoEditar                     | nome            | telefone       | email                    |
      | Marciano Verdinho das Antenas Longas | Etê de Varginha | 98 7 6543-2100 | et-varginha@marte.com.br |

  @EmprestimosExclusao @EmprestimosExclusaoConfirmar
  Scenario Outline: Excluindo pessoa confirmando exclusão
    Given que existem empréstimos
      | tipo      | dataEmprestimo           | situacao   | dataDevolucao            | pessoa                           | observacoes                           | itens                                                                     |
      | CONCEDIDO | 2019-06-03T03:00:00.000Z | EMPRESTADO | 2019-06-07T03:00:00.000Z | Magnesia Bisurada do Patrocinio  | Empréstimo concedido no dia seguinte. | [{"codigo":"1","descricao":"Laptop Samsung","quantidade":1,"valor":35.5}] |
    And o usuário acessou o menu empréstimos
    When clicar no botão com o título "Excluir" do empréstimo "<emprestimoExcluir>"
    Then deveria exibir a mensagem "Deseja realmente excluir o registro?"
    And aguardar 1 segundo
    When clicar no botão com o texto "Sim!"
    And aguardar 1 segundo
    Then deveria exibir a mensagem "Empréstimo excluído com sucesso"
    And aguardar 3 segundos
    Then deveria existir <quantidade> empréstimos
    # And não deveria exibir "<emprestimo>" na lista de empréstimos

    Examples:
      | emprestimoExcluir               | quantidade |
      | Magnesia Bisurada do Patrocinio | 0          |

  @EmprestimosExclusao @EmprestimosExclusaoCancelar
  Scenario Outline: Excluindo pessoa cancelando exclusão
    Given que existem empréstimos
      | tipo      | dataEmprestimo           | situacao   | dataDevolucao            | pessoa                               | observacoes                           | itens                                                                     |
      | CONCEDIDO | 2019-06-03T03:00:00.000Z | EMPRESTADO | 2019-06-07T03:00:00.000Z | Sete Chagas de Jesus e Salve Patria  | Empréstimo concedido no dia seguinte. | [{"codigo":"1","descricao":"Laptop Samsung","quantidade":1,"valor":35.5}] |
    And o usuário acessou o menu empréstimos
    When clicar no botão com o título "Excluir" do empréstimo "<emprestimo>"
    Then deveria exibir a mensagem "Deseja realmente excluir o registro?"
    And aguardar 1 segundo
    When clicar no botão com o texto "Não tenho certeza"
    And aguardar 1 segundo
    Then deveria existir <quantidade> empréstimos
    And deveria exibir "<emprestimo>" na lista de empréstimos

    Examples:
      | emprestimo                          | quantidade |
      | Sete Chagas de Jesus e Salve Patria | 1          |
