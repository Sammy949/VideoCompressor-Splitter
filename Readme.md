\# 🎥 Video Compressor \& Splitter — PowerShell + FFmpeg



A simple PowerShell automation script that \*\*compresses large videos\*\* and \*\*splits them into clean 10-minute parts\*\* using `ffmpeg`.  

Perfect for uploading long recordings like sermons, podcasts, or school content in smaller chunks.



---



\## 🚀 Features



\- ✅ Compresses videos using a target bitrate (default: 1000kbps)

\- ✂️ Splits the compressed video into 10-minute chunks

\- 🧼 Automatically renames the chunks: `Part 1.mp4`, `Part 2.mp4`, ...

\- 🗂 Neatly organises output into a named folder (e.g. `Sunday Service`)

\- 📜 Written entirely in PowerShell – easy to edit, extend, or run directly



---



\## 📂 How It Works



\### 1. Place your `video.mp4` in the folder

Make sure it's named exactly `video.mp4`, or change the `$input` variable in the script.



\### 2. Run the Script



If you're on Windows and have PowerShell + FFmpeg installed:



```bash

./compression\_script.ps1

````



The script does the following:



\* Compresses `video.mp4` to `Sunday Service/compressed.mp4`

\* Splits that compressed file into 10-minute `.mp4` parts

\* Renames and stores them as:



&nbsp; \* `Part 1.mp4`

&nbsp; \* `Part 2.mp4`

&nbsp; \* ...

&nbsp;   inside the `Sunday Service` folder



---



\## 🛠 Configuration



You can tweak the config block at the top of the script:



```powershell

$input = "video.mp4"

$serviceName = "Sunday Service"

$splitDuration = 600  # in seconds (600s = 10 mins)

$targetBitrate = "1000k"

$audioBitrate = "96k"

```



---



\## 📜 The Script (Full Source)



```powershell

\# === CONFIG ===

$input = "video.mp4"  # Change this if your video has a different name

$serviceName = "Sunday Service"

$compressed = "$serviceName\\compressed.mp4"

$splitDuration = 600  # 600 seconds = 10 minutes per part



\# === STEP 1: Create output folder ===

if (!(Test-Path $serviceName)) {

&nbsp;   New-Item -ItemType Directory -Path $serviceName | Out-Null

}



\# === STEP 2: Compress the video with size optimisation ===

Write-Host "`nCompressing '$input' to '$compressed' (target bitrate)..."



\# 1000k video bitrate ≈ good enough for 1080p phone video

$targetBitrate = "1000k"

$audioBitrate = "96k"



ffmpeg -i $input `

&nbsp;   -c:v libx264 `

&nbsp;   -b:v $targetBitrate `

&nbsp;   -profile:v baseline `

&nbsp;   -preset medium `

&nbsp;   -c:a aac `

&nbsp;   -b:a $audioBitrate `

&nbsp;   -movflags +faststart `

&nbsp;   "$compressed"



\# === STEP 3: Split the compressed video into parts ===

Write-Host "`nSplitting compressed video into 10-minute chunks..."



$tempPartPattern = "$serviceName\\temp\_part\_%03d.mp4"



ffmpeg -i "$compressed" `

&nbsp;   -c copy `

&nbsp;   -map 0 `

&nbsp;   -segment\_time $splitDuration `

&nbsp;   -f segment `

&nbsp;   -reset\_timestamps 1 `

&nbsp;   "$tempPartPattern"



\# === STEP 4: Rename parts cleanly ===

Write-Host "`nRenaming parts..."



$files = Get-ChildItem "$serviceName\\temp\_part\_\*.mp4" | Sort-Object Name

$count = 1



foreach ($file in $files) {

&nbsp;   $newName = "Part $count.mp4"

&nbsp;   $destination = Join-Path -Path $serviceName -ChildPath $newName

&nbsp;   Rename-Item -Path $file.FullName -NewName $destination

&nbsp;   $count++

}



Write-Host "`nDone! Check the '$serviceName' folder for your compressed and split videos."

```



---



\## 💡 Requirements



\* ✅ \[FFmpeg](https://ffmpeg.org/download.html) installed and added to PATH

\* ✅ PowerShell (Windows Terminal or VSCode terminal)



---



\## 🧑‍💻 Author



\*\*Samuel Urah Yahaya\*\*

📍 Nigeria

🌐 \[samy01.netlify.app](https://samy01.netlify.app)

📧 \[urahsamuel0202@gmail.com](mailto:urahsamuel0202@gmail.com)

🔗 \[LinkedIn](https://www.linkedin.com/in/samuel-urah-yahaya-9162a4239/) | \[GitHub](https://github.com/Sammy949)



---



\## 📝 License



This project is licensed under the \[MIT License](LICENSE) — free to use, modify, and distribute.



---



\## ✨ Want more?



Like this? Want a `.bat` version, Linux `.sh` version, or even a GUI app version?

Feel free to open an issue or PR!



---



````



---



\### 📌 Next Steps



1\. Create a new folder, place:

&nbsp;  - `README.md`

&nbsp;  - `compression\_script.ps1`



2\. Initialise git:



&nbsp;  ```bash

&nbsp;  git init

&nbsp;  git add .

&nbsp;  git commit -m "Initial commit with compression \& splitter script"

&nbsp;  git remote add origin https://github.com/YOUR\_USERNAME/video-compressor-splitter.git

&nbsp;  git push -u origin main

````



And you're live!

