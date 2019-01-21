x <- data.frame(wb_mason = rlnorm(n=10000, mean = 4.4, sd =0.63), office_depot = rlnorm(n=10000, mean = 2.5, sd =.9), staples = rlnorm(n=10000, mean = 4.9, sd =0.55))
head(x)
library(tidyr)
x_tidy <- gather(x)
colnames(x_tidy) <- c("Reseller", "AFP")
library(ggplot2)

#Calculate means

library(plyr)
mu <- ddply(x_tidy, "Reseller", summarise, grp.mean=mean(AFP))
head(mu)

x_tidy <- x_tidy[x_tidy$AFP<250,]

p<-ggplot(x_tidy, aes(x=AFP, color=Reseller)) +
  geom_histogram(fill="white", position="dodge")+
  geom_vline(data=mu, aes(xintercept=grp.mean, color=Reseller),
             linetype="dashed")+
  theme(legend.position="top")

p+scale_color_brewer(palette="Dark2")

#Use Facets

ggplot(x_tidy, aes(x=AFP, color=Reseller, fill = Reseller)) +
  geom_histogram(aes(y=..density..), position="identity", alpha=0.5)+
  geom_density(alpha=0.6)+
  geom_vline(data=mu, aes(xintercept=grp.mean, color=Reseller),
             linetype="dashed")+
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  labs(title="AFP by Reseller",x="AFP in Days", y = "Density")+
  theme_classic()

