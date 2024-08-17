# MZ-80K_SDをMZ-700のバンク切替に対応(テスト中)

![MZ-700_SD](https://github.com/yanataka60/MZ-700_SD/blob/main/JPEG/MZ-700_SD_1.JPG)

　MZ-80K_SDはROMをF000Hに置くことでFDコマンドを利用してフロッピーディスク装置の代わりにSD-CARDを繋いでしまおうというものですが、MZ-700ではバンク切替によりオールRAMとなったときに、MZ-80K_SDのROMとぶつかってしまいます。

　そのままMZ-700で使って使えないことも無いのですが、バンクが切り替わったときにはROMがDisableになったほうが安心です。

　MZ-80K_SDのページではスイッチでROMを切り離す方法を紹介しています。
https://github.com/yanataka60/MZ80K_SD?tab=readme-ov-file#rom%E5%88%87%E3%82%8A%E9%9B%A2%E3%81%97%E3%82%B9%E3%82%A4%E3%83%83%E3%83%81%E6%94%B9%E9%80%A0

　こちらではGAL16V8を使ってバンクが切り替わったときに自動でROMをDisable、Enableする方式です。

####  ただし、MZ-80K_SD開発時に使っていたGAL22V10がMZ-80K本体と相性が悪いのかどうにも動作が不安定で泣く泣く汎用ロジックICに置き換えた経験から動作が安定していると確信できるまではテスト公開とします。

####  また、汎用ロジックICに比べてGAL16V8の入手性もよくありません。

　なお、GAL16V8、Arduino、ROMへ書き込むための機器が別途必要となります。

## 回路図
　KiCadフォルダ内のMZ-700_SD.pdf参照

[回路図](https://github.com/yanataka60/MZ-700_SD/blob/main/KiCad/MZ700_SD.pdf)
![回路図](https://github.com/yanataka60/MZ-700_SD/blob/main/KiCad/MZ700_SD_1.jpg)

## 部品
　U7 GAL16V8 1個が追加された以外はMZ-80K_SD Rev1.5.3と同様です。

https://github.com/yanataka60/MZ80K_SD?tab=readme-ov-file#%E9%83%A8%E5%93%81

## GAL16V8プログラム
Wincuplフォルダ内のMZ700_ROM.jedをROMライター(TL866II Plus等)を使って書き込んでください。

## ROMプログラムについて
## Arduinoプログラム
以下、MZ-80K_SD Rev1.5.3と同様ですのでMZ-80K_SDプロジェクトを参照してください。。

https://github.com/yanataka60/MZ80K_SD?tab=readme-ov-file#rom%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6

## 謝辞
　基板の作成に当たり以下のデータを使わせていただきました。ありがとうございました。

　Arduino Pro Mini

　　https://github.com/g200kg/kicad-lib-arduino

　AE-microSD-LLCNV

　　https://github.com/kuninet/PC-8001-SD-8kRAM

