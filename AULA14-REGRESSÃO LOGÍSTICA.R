#Variável categórica 
#Criamos um modelo para quando a variável dicotomica 

#Pré-requisitos 
#Ausência de multicolineariedade 
#Ausência de outiliers 
#Relação linear entre o logito e cada variável
#independente (contínua) - teste box-tidwell

#montar e interpretar o modelo 
#comparar diferentes modelos 
#descrever os resultados 

#Carregar os pacotes
if(!require(pacman))install.packages("pacman")
pacman::p_load(dplyr, psych, car, MASS, DescTools,
               Quantpsyc, ggplot2)

#Avisar aos alunos para def. o diretório
#Abrir a base de dados 

library(readr)

dados <- read_delim("Banco de Dados 13.csv", 
                                delim = ";", escape_double = FALSE, 
                                locale = locale(encoding = "LATIN1"), 
                                trim_ws = TRUE)

#Análise das frequências 
#Não é ideal fazer a regressão logística 
#quando temos um banco com quantidade de 
#observações por categorias tão grande

head(dados)
table(dados$Hab_Fumar)
summary(dados)

#Analisar e organizar os lavels
levels(dados$Cancer)
levels(dados$Hab_Fumar)

dados$Cancer <- as.factor(dados$Cancer)
dados$Cancer <- relevel(dados$Cancer, 
                             ref= "Não")


dados$Hab_Fumar <- as.factor(dados$Hab_Fumar)
dados$Hab_Fumar <- relevel(dados$Hab_Fumar, 
                        ref= "Não")

#Análise dos pressupostos
#A variável dependente deve ser categórica - dicotômica
#composto por categorias mutuamente excludentes *** explicar 
#Independência das observações (sem medidas repetidas) -

#contrução do modelo

Modelo <-  glm(Cancer ~ Estresse + Hab_Fumar, 
               family = binomial(link = 'logit'),
               data = dados)

#Verificar a ausência de outliers 
plot(Modelo, which=5)
#Gráfico de pontos de alavancagem
#nenhum ponto dentro da linha pontilhada - ok

summary(stdres(Modelo))
#Resíduos padronizados 
# Min.  1st Qu.   Median 
# -2.76601 -0.47826  0.33612 
# Mean  3rd Qu.     Max. 
# -0.00158  0.51878  2.33953 

#O intervalo deve ser -3 e +3 para estar ok

#Ausência de multicolinearidade
pairs.panels(dados)
#Histograma para todas 
#Correlação para todas - não pode ser uma correção perfeita ou quase perfeita ** explicar- verificar se lembram

vif(Modelo) #VIF > 10
# Estresse Hab_Fumar 
# 1.28416   1.28416 


#Relação linear entre cada Variável independente 
# e o logito da variável dependente 
#basicamente preciso calcular
#As variáveis que são continuas 
#seu valor multiplicado pelo seu próprio 
#valor, porém logaritmizado

logito <- Modelo$linear.predictors

dados$logito <- logito

#Análise desse resultado
ggplot(dados, aes(logito, Estresse))+
  geom_point(size= 0.5, alpha = 0.5) +
  geom_smooth(method = "loess") +
  theme_classic()


#Análise do modelo

library(sjPlot)
tab_model(Modelo, show.ci = F, 
          p.style = "stars")

#habito de fumar 
#Transformação em porcentage
#(odds ratios - 1)*100
8.72 - 1
#[1] 7.72
7.72 *100
#772%

#Outra forma de interpretar o OR
exp(cbind(OR = coef(Modelo), 
          confint.default(Modelo)))

#Verificar se os alunos lembram do pressuposto sobre a inserção
#ou retirada das variáveis 
#Comparação entre os modelos 


Modelo2 <-  glm(Cancer ~ Hab_Fumar, 
               family = binomial(link = 'logit'),
               data = dados)

tab_model(Modelo2,
          show.ci = F, 
          p.style = "stars")

###
#Apresentação dos resultados

library(coefplot)
coefplot(Modelo)

coefplot1 <- plot_model(Modelo, 
                        show.intercept = F, 
                        show.p = T, 
                        show.values = T, 
                        value.size = 4,
                        digits = 2, 
                        vline.color = "pink", 
                        sort.est = T, 
                        width = 0.05) 

coefplot1

coefplot(Modelo2)

coefplot2 <- plot_model(Modelo2, 
                        show.intercept = F, 
                        show.p = T, 
                        show.values = T, 
                        value.size = 4,
                        digits = 2, 
                        vline.color = "pink", 
                        sort.est = T, 
                        width = 0.05) 

coefplot2+
theme_classic() +
  scale_color_sjplot("system")

#Pseudo R2 - não temos r2 para a regressão logística

PseudoR2(Modelo, which = "Nagelkerke")

PseudoR2(Modelo2, which = "Nagelkerke")

#Comparação entre os modelos 
#AIC e BIC 
#Quanto menor o valor menor.
AIC(Modelo, Modelo2)
BIC(Modelo, Modelo2)
#quando não tem uma diferença de nem 
#10 pontos consideramos que os modelos
#são iguais, mas escolhemos que tem 
#mais variáveis significativas




#Comparação entre os modelos 
#AIC e BIC 


