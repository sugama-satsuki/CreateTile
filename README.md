# CreateTile
excelファイル、csvファイル、geojsonファイルからpmtilesを作成します。

## 使い方
``` shell
cd ~/Desktop
git clone https://github.com/sugama-satsuki/CreateTile.git
```
テストデータとして、excelファイルcsvファイルを置いています。

```
data
  └ 12_suisyou_koukyoushisetu-1.xlsx
  └ 470007_hospital.csv
  └ 473022_evacuation_space.csv
```

---
① pmtilesファイルに変換したいexcelファイル、csvファイル、geojsonファイルを `data` フォルダへ格納


② ターミナルにて、下記を実行。
```shell
# bash使用の場合
bash ~/Desktop/CreateTile/bin/tile.sh
```
