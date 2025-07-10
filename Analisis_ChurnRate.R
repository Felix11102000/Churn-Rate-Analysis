# =============================================
# 📥 1. Import Data
# =============================================
library(readxl)
data <- read_excel("C:/Users/Felix Usmany/Documents/Data Analyst/telco_churn.xlsx")

# Cek struktur & ringkasan data
str(data)
summary(data)

# =============================================
# 🔎 2. Data Cleaning
# =============================================
data$TotalCharges <- as.numeric(as.character(data$TotalCharges))

# Tangani missing values
sum(is.na(data))
data <- na.omit(data)

# Ubah Churn jadi biner (0/1)
data$Churn_bin <- ifelse(data$Churn == "Yes", 1, 0)

# =============================================
# 📊 3. Univariat: churn rate per variabel
# =============================================

library(dplyr)

# Churn rate keseluruhan
mean(data$Churn_bin)

# Churn rate by Contract
data %>%
  group_by(Contract) %>%
  summarise(
    total = n(),
    churned = sum(Churn_bin),
    churn_rate = round(100 * mean(Churn_bin), 2)
  )

# Churn rate by InternetService
data %>%
  group_by(InternetService) %>%
  summarise(
    total = n(),
    churned = sum(Churn_bin),
    churn_rate = round(100 * mean(Churn_bin), 2)
  )

# Churn rate by tenure group
data$tenure_group <- cut(data$tenure,
                         breaks = c(0, 12, 24, 36, 48, 60, 72),
                         labels = c("0-12", "13-24", "25-36", "37-48", "49-60", "61-72"))

data %>%
  group_by(tenure_group) %>%
  summarise(
    total = n(),
    churned = sum(Churn_bin),
    churn_rate = round(100 * mean(Churn_bin), 2)
  )

# =============================================
# 📈 4. Visualisasi Univariat
# =============================================

library(ggplot2)
library(patchwork) 

p1 <- ggplot(data, aes(x = Contract, fill = Churn)) +
  geom_bar(position = "fill") +
  ylab("Proportion") +
  ggtitle("Churn Rate by Contract") +
  scale_fill_manual(values = c("No" = "green", "Yes" = "red"))

p2 <- ggplot(data, aes(x = InternetService, fill = Churn)) +
  geom_bar(position = "fill") +
  ylab("Proportion") +
  ggtitle("Churn Rate by Internet Service") +
  scale_fill_manual(values = c("No" = "green", "Yes" = "red"))

p3 <- ggplot(data, aes(x = tenure_group, fill = Churn)) +
  geom_bar(position = "fill") +
  ylab("Proportion") +
  ggtitle("Churn Rate by Tenure Group") +
  scale_fill_manual(values = c("No" = "green", "Yes" = "red"))

library(gridExtra)
grid.arrange(p1, p2, p3, ncol = 2)


# =============================================
# 🔢 5. Logistic Regression
# =============================================

model <- glm(
  Churn_bin ~ tenure + MonthlyCharges + TotalCharges +
    Contract + InternetService + SeniorCitizen + Partner + Dependents,
  data = data,
  family = "binomial"
)

summary(model)

# =============================================
# 📋 6. Interpretasi koefisien
# =============================================

# Odds Ratio
exp(coef(model))

# Odds Ratio dengan CI
exp(cbind(OR = coef(model), confint(model)))

# =============================================
# 📌 7. Prediksi & Evaluasi (opsional)
# =============================================

# Prediksi probabilitas
data$pred_prob <- predict(model, type = "response")

# Prediksi kelas (threshold 0.5)
data$pred_class <- ifelse(data$pred_prob >= 0.5, 1, 0)

# Confusion Matrix
table(Predicted = data$pred_class, Actual = data$Churn_bin)

# Akurasi sederhana
mean(data$pred_class == data$Churn_bin)
