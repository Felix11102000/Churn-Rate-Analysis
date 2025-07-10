# 📊 Telco Customer Churn Analysis

Analisis churn pelanggan Telco menggunakan kombinasi **SQL**, **R**, & **Power BI** 
---

## 📋 1. Tujuan Analisis

- Mengukur churn rate pelanggan.
- Mengidentifikasi faktor-faktor yang signifikan memengaruhi churn.
- Membangun model prediksi churn.
- Memberikan rekomendasi strategi retensi pelanggan.

📄 **Dataset**: Data pelanggan layanan telekomunikasi dengan fitur demografi, layanan yang dipilih, lama berlangganan, dan status churn.  
📈 Total pelanggan: **7,043**

---

## 🔍 2. Eksplorasi Data & Churn Rate

📁 Lihat sintaks SQL lengkap di file: [`churn_rate.sql`](./churn_rate.sql)

📌 **Hasil eksplorasi (SQL + R):**

| Faktor                   | Insight |
|--------------------------|---------|
| **Churn Rate**           | ~26.54% (1,869 dari 7,043) |
| **Contract**             | Month-to-Month → churn rate tertinggi |
| **Internet Service**     | Fiber optic → churn lebih tinggi dari DSL |
| **Tenure** *(R)*         | Pelanggan baru (tenure <12 bulan) lebih rentan churn |
| **Senior Citizen** *(R)* | Pelanggan senior lebih cenderung churn |
| **Dependents** *(R)*     | Pelanggan dengan tanggungan lebih loyal |

Catatan: faktor dengan tanda *(R)* dianalisis dari model & visualisasi di R.---

---

## 🎨 3. Visualisasi dengan Power BI dan R

📁 Lihat Dashboard Visualisasi **Power BI** di file: [`Visualisasi_ChurnRate.png`](./Visualisasi_ChurnRate.png)

📁 Lihat  Visualisasi menggunakan **R** di file: [`Visualisasi_R.png`](./Visualisasi_R.png)

Visualisasi dibuat untuk:
- Churn vs Contract
- Churn vs Internet Service
- Churn vs Tenure Group
**dibuat dalam satu dashboard untuk mengontrol Churn rate

---

## 🤖 4. Model Prediksi Churn 
📁 Lihat kode R lengkap di file: [`Analisis_ChurnRate.R`](./Analisis_ChurnRate.R)

- Model: **Logistic Regression**
- Target: Churn (`Yes`=1, `No`=0)
- Akurasi model: **79.15%**

### 📋 Variabel Signifikan:
| Variabel                 | Odds Ratio | Interpretasi |
|--------------------------|------------|--------------|
| **Tenure**               | 0.97       | tiap bulan bertahan → risiko churn turun ~3% |
| **Contract: One year**   | 0.45       | kontrak 1 tahun → risiko churn ~55% lebih rendah |
| **Contract: Two year**   | 0.20       | kontrak 2 tahun → risiko churn ~80% lebih rendah |
| **Internet: Fiber optic**| 3.00       | fiber optic → 3× lipat risiko churn |
| **Internet: No**         | 0.37       | tanpa internet → lebih loyal |
| **Senior Citizen**       | 1.41       | senior → 41% lebih mungkin churn |
| **Dependents: Yes**      | 0.80       | dengan tanggungan → lebih loyal |

📌 Variabel **MonthlyCharges**, **TotalCharges**, & **Partner** tidak signifikan.

---

## 📈 5. Evaluasi Model

### Confusion Matrix:
|            | Actual 0 | Actual 1 |
|------------|----------|----------|
| **Pred 0** | 4,623    | 926      |
| **Pred 1** | 540      | 943      |

### Metrik:
| Metrik      | Nilai    |
|-------------|---------|
| **Precision** | ~63.6% |
| **Recall**    | ~50.5% |
| **F1 Score**  | ~56.2% |

---

## 💡 6. Rekomendasi Strategi

🎯 Dorong kontrak panjang: Berikan promo khusus untuk kontrak 1–2 tahun.  
🎯 Tingkatkan kualitas layanan Fiber optic: Fokus pada harga & kualitas karena pelanggan fiber memiliki risiko churn tinggi.  
🎯 Program loyalitas untuk pelanggan baru & senior citizen: karena mereka lebih rentan churn.  
🎯 Upsell pada pelanggan dengan tanggungan: mereka lebih loyal.

---

## 🔧 Teknologi & Tools

- 📄 SQL: MySQL — eksplorasi & pembersihan data
- 📊 R: Analisis & pemodelan
- 📈 Power BI: Visualisasi data
- 🧪 Evaluasi: Confusion Matrix, Odds Ratio

---

## 📂 Struktur File

├── README.md
├── churn_rate.sql
├── Analisis_ChurnRate.R
