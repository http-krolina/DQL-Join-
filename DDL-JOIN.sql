-- Relatório 1
SELECT E.nome AS Nome_Empregado, E.cpf, E.dataAdm, E.salario, D.nome AS Departamento, T.numero AS Telefone
FROM Empregado E
JOIN Departamento D ON E.Departamento_idDepartamento = D.idDepartamento
JOIN Telefone T ON T.Empregado_cpf = E.cpf
WHERE E.dataAdm BETWEEN '2019-01-01' AND '2022-03-31'
ORDER BY E.dataAdm DESC;

-- Relatório 2
SELECT E.nome AS Nome_Empregado, E.cpf, E.dataAdm, E.salario, D.nome AS Departamento, T.numero AS Telefone
FROM Empregado E
JOIN Departamento D ON E.Departamento_idDepartamento = D.idDepartamento
JOIN Telefone T ON T.Empregado_cpf = E.cpf
WHERE E.salario < (SELECT AVG(salario) FROM Empregado)
ORDER BY E.nome;

-- Relatório 3
SELECT D.nome AS Departamento, COUNT(E.cpf) AS Quant_Empregados, 
       AVG(E.salario) AS Media_Salarial, AVG(E.comissao) AS Media_Comissao
FROM Departamento D
LEFT JOIN Empregado E ON E.Departamento_idDepartamento = D.idDepartamento
GROUP BY D.nome
ORDER BY D.nome;

-- Relatório 4
SELECT E.nome, E.cpf, E.sexo, E.salario,
       COUNT(V.idVenda) AS Qtd_Vendas, 
       SUM(V.valor) AS Total_Vendido, 
       SUM(V.comissao) AS Total_Comissao
FROM Empregado E
LEFT JOIN Venda V ON V.Empregado_cpf = E.cpf
GROUP BY E.nome, E.cpf, E.sexo, E.salario
ORDER BY Qtd_Vendas DESC;

-- Relatório 5
SELECT E.nome, E.cpf, E.sexo, E.salario,
       COUNT(DISTINCT IS1.Venda_idVenda) AS Qtd_Vendas_Servico,
       SUM(IS1.valor) AS Total_Servico,
       SUM(V.comissao) AS Total_Comissao
FROM Empregado E
JOIN itensServico IS1 ON IS1.Empregado_cpf = E.cpf
JOIN Venda V ON V.idVenda = IS1.Venda_idVenda
GROUP BY E.nome, E.cpf, E.sexo, E.salario
ORDER BY Qtd_Vendas_Servico DESC;

-- Relatório 6
SELECT P.nome AS Nome_Pet, V.data, S.nome AS Nome_Servico, IS1.quantidade, IS1.valor, E.nome AS Empregado
FROM itensServico IS1
JOIN Servico S ON S.idServico = IS1.Servico_idServico
JOIN PET P ON P.idPET = IS1.PET_idPET
JOIN Venda V ON V.idVenda = IS1.Venda_idVenda
JOIN Empregado E ON E.cpf = IS1.Empregado_cpf
ORDER BY V.data DESC;

-- Relatório 7
SELECT V.data, V.valor, V.desconto,
       (V.valor - IFNULL(V.desconto, 0)) AS Valor_Final,
       E.nome AS Empregado
FROM Venda V
JOIN Empregado E ON E.cpf = V.Empregado_cpf
WHERE V.Cliente_cpf IS NOT NULL
ORDER BY V.data DESC;

-- Relatório 8
SELECT S.nome AS Nome_Servico,
       COUNT(IS1.Venda_idVenda) AS Quantidade_Vendas,
       SUM(IS1.valor) AS Total_Valor
FROM itensServico IS1
JOIN Servico S ON S.idServico = IS1.Servico_idServico
GROUP BY S.nome
ORDER BY Quantidade_Vendas DESC
LIMIT 10;

-- Relatório 9
SELECT FP.tipo AS Tipo_Forma_Pagamento,
       COUNT(FP.idFormaPgVenda) AS Quantidade_Vendas,
       SUM(FP.valorPago) AS Total_Valor
FROM FormaPgVenda FP
GROUP BY FP.tipo
ORDER BY Quantidade_Vendas DESC;

-- Relatório 10
SELECT DATE(V.data) AS Data_Venda,
       COUNT(*) AS Quantidade_Vendas,
       SUM(V.valor) AS Total_Venda
FROM Venda V
GROUP BY DATE(V.data)
ORDER BY Data_Venda DESC;

-- Relatório 11
SELECT 
  P.nome AS Nome_Produto, 
  P.valorVenda AS Valor_Produto, 
  P.marca AS Categoria,
  F.nome AS Nome_Fornecedor, 
  F.email, 
  T.numero AS Telefone
FROM Produtos P
JOIN ItensCompra IC ON IC.Produtos_idProduto = P.idProduto
JOIN Compras C ON C.idCompra = IC.Compras_idCompra
JOIN Fornecedor F ON F.cpf_cnpj = C.Fornecedor_cpf_cnpj
LEFT JOIN Telefone T ON T.Fornecedor_cpf_cnpj = F.cpf_cnpj
LIMIT 1000;


-- Relatório 12
SELECT P.nome AS Nome_Produto,
       COUNT(IVP.Venda_idVenda) AS Qtd_Vendas,
       SUM(IVP.valor) AS Valor_Total
FROM ItensVendaProd IVP
JOIN Produtos P ON P.idProduto = IVP.Produto_idProduto
GROUP BY P.nome
ORDER BY Qtd_Vendas DESC;
