library('ggplot2')
library('plyr')

mosquito = read.csv('/Users/jfehr/Documents/AI_Scope_Sleepover/mos_final.csv', header=TRUE)
larva = read.csv('/Users/jfehr/Documents/AI_Scope_Sleepover/larva_final.csv', header=TRUE)
twoG = read.csv2('/Users/jfehr/Documents/AI_Scope_Sleepover/2G.csv', header=TRUE, sep=';')


disease.plt = ggplot(mosquito, aes(x = as.Date(FECHA_ING), fill = Disease)) + 
  geom_histogram(alpha = 0.5, bins = 50) +
  facet_wrap(~Disease, ncol = 1, scales = 'free_y') +
  scale_fill_manual(values=c("red", "#E69F00")) +
  xlab('time') +
  scale_x_date(limits=as.Date(c('2005-01-01', '2018-01-01'))) +
  theme_bw() +
  theme(panel.grid.minor = element_line(colour = 'grey50'))

ggsave('/Users/jfehr/Documents/AI_Scope_Sleepover/disease_plt2.png', plot = disease.plt, width = 7, height = 5, device='png' )


dfm = mosquito[grepl('MALARIA', mosquito$DIAGNO),]

malaria.plt = ggplot(data=dfm, aes(x = as.Date(FECHA_ING), fill = Larva)) + 
  geom_histogram(alpha = 0.5, bins = 5*12) +
  facet_wrap(~Larva, ncol = 2, scales = 'free_y') +
  scale_x_date(limits=as.Date(c('2005-01-01', '2018-01-01'))) +
  xlab('time') +
  theme_bw() +
  theme(panel.grid.minor = element_line(colour = 'grey50'))
ggsave('/Users/jfehr/Documents/AI_Scope_Sleepover/malaria_allYears2.png', plot = malaria.plt, width = 7, height = 5, device='png' )

malaria_2016 = ggplot(data=dfm[(dfm$Larva == 'PFALCIPARUM' | dfm$Larva == 'VIVAX'),], 
                      aes(x = as.Date(FECHA_ING), fill = Larva)) + 
  geom_histogram(alpha = 0.5, bins = 12*3) +
  facet_wrap(~Larva, ncol = 1, scales = 'free_y') +
  scale_x_date(limits=as.Date(c('2016-01-01', '2017-01-01'))) +
  xlab('time') +
  theme_bw() +
  theme(panel.grid.minor = element_line(colour = 'grey50'))
ggsave('/Users/jfehr/Documents/AI_Scope_Sleepover/malaria_2016.png', plot = malaria_2016, width = 7, height = 10, device='png' )



# Relative Malaria cases per month
df_2017 = dfm[dfm$Year==2017,]
#For each month get the total number of Malaria cases per strain
mal_2017_total = ddply(df_2017, .(Month, Larva), function(X){cnt_monthly_cases=nrow(X)})

