
# 📼 Video Compressor & Splitter

This PowerShell script is used to compress and split a video file (typically shot on an Android phone) into smaller, more manageable chunks for easier sharing and uploading — such as via WhatsApp or Google Drive.

---

## 🔧 Features

- **Compresses** a large video file to reduce file size while preserving reasonable quality.
- **Splits** the compressed video into multiple 10-minute segments.
- **Renames** each segment for better readability and organisation.

---

## 📂 Output Structure

```
Sunday Service/
├── compressed.mp4                 # Full compressed version of the original
├── Sunday Service - Part 1.mp4    # First 10 minutes
├── Sunday Service - Part 2.mp4    # Next 10 minutes
├── Sunday Service - Part 3.mp4    # ...
```

---

## ⚙️ How It Works

### STEP 1: Create Output Folder

Creates a folder called `Sunday Service` to store all output files.

### STEP 2: Compress the Video

Uses `ffmpeg` with a video bitrate of `1000k` and audio bitrate of `96k` to compress the video.

### STEP 3: Split the Compressed Video

Splits the output into 10-minute chunks using `ffmpeg`'s segment feature.

### STEP 4: Rename Split Files

Renames each chunk to a user-friendly format: `Sunday Service - Part 1.mp4`, etc.

---

## ▶️ Requirements

- PowerShell
- [FFmpeg](https://ffmpeg.org/) installed and added to your system path

---

## 🚀 Usage

1. Place your original video in the same folder and rename it to `video.mp4` (or change the script variable).
2. Run the script:

```powershell
./compression_script.ps1
```

3. Find your compressed and split video files inside the `Sunday Service` folder.

---

## 🧠 Notes

- Bitrate can be adjusted for higher or lower quality by editing the `$targetBitrate` value in the script.
- You can also change the `$splitDuration` (default: 600 seconds = 10 mins).
- You can chage the name of the folder, and the video titles and others.

Feel free to fork this project, raise pull requests, and other cool features.
---

## 📫 Created by Samuel Urah Yahaya

> Made with love to simplify the stress of sharing long recordings online 💡
