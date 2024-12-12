# AIC e BIC: Critérios de Informação
## "Análise dos critérios de regressão logística para a turma de doutorado em CP da UFPA"

**Autora**: Profa. Naiara Sandi de Almeida Alcantara  
**Data**: 13/12  

---

## Introdução

O **AIC** (Critério de Informação de Akaike) e o **BIC** (Critério de Informação Bayesiano) são métricas usadas para comparar modelos estatísticos, ajudando a escolher o modelo mais adequado entre várias alternativas. Eles avaliam o equilíbrio entre o ajuste do modelo aos dados e sua complexidade, penalizando modelos com muitos parâmetros para evitar **overfitting**.

---

## AIC (Akaike Information Criterion)

### Fórmula

\[
AIC = -2 \ln(L) + 2k
\]

Onde:  
- \( L \): verossimilhança do modelo (mede o ajuste do modelo aos dados).  
- \( k \): número de parâmetros estimados no modelo.  

### Interpretação
- Penaliza modelos mais complexos (com mais parâmetros) para evitar o ajuste excessivo aos dados.
- Um valor menor de AIC indica um modelo melhor, mas **somente entre modelos comparáveis** com os mesmos dados.

### Uso
- Muito usado em modelos como regressão, séries temporais e modelos lineares generalizados.

---

## BIC (Bayesian Information Criterion)

### Fórmula

\[
BIC = -2 \ln(L) + k \ln(n)
\]

Onde:  
- \( n \): número de observações no conjunto de dados.  
- \( k \): número de parâmetros do modelo.  
- \( L \): verossimilhança do modelo.  

### Interpretação
- Similar ao AIC, mas penaliza mais fortemente modelos complexos, especialmente quando o tamanho da amostra (\( n \)) é grande.
- Como o AIC, um valor menor de BIC é melhor.

### Uso
- Preferido em contextos onde há maior preocupação com a parcimônia do modelo, como na seleção de modelos em estudos bayesianos.

---

## Diferenças principais

| Aspecto            | **AIC**                              | **BIC**                              |
|---------------------|--------------------------------------|--------------------------------------|
| Penalização         | Menos severa                        | Mais severa                          |
| Depende do tamanho da amostra (\( n \)) | Não diretamente                       | Sim                                  |
| Aplicação           | Melhor para previsão (mais flexível)| Melhor para identificação do modelo verdadeiro (mais rígido) |

---

## Conclusão prática

- Use **AIC** quando o foco é previsão e você está disposto a considerar modelos ligeiramente mais complexos.
- Use **BIC** quando o foco é identificar o modelo mais provável de ser o "correto", especialmente com grandes conjuntos de dados.

