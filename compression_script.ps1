# === CONFIG ===
$input = "video.mp4"  # Change this if your video has a different name
$serviceName = "Sunday Service"
$compressed = "$serviceName\compressed.mp4"
$splitDuration = 600  # 600 seconds = 10 minutes per part

# === STEP 1: Create output folder ===
if (!(Test-Path $serviceName)) {
    New-Item -ItemType Directory -Path $serviceName | Out-Null
}

# === STEP 2: Compress the video with size optimisation ===
Write-Host "`nCompressing '$input' to '$compressed' (target bitrate)..."

# 1000k video bitrate ≈ good enough for 1080p phone video
$targetBitrate = "1000k"
$audioBitrate = "96k"

ffmpeg -i $input `
    -c:v libx264 `
    -b:v $targetBitrate `
    -profile:v baseline `
    -preset medium `
    -c:a aac `
    -b:a $audioBitrate `
    -movflags +faststart `
    "$compressed"

# === STEP 3: Split the compressed video into parts ===
Write-Host "`nSplitting compressed video into 10-minute chunks..."

$tempPartPattern = "$serviceName\temp_part_%03d.mp4"

ffmpeg -i "$compressed" `
    -c copy `
    -map 0 `
    -segment_time $splitDuration `
    -f segment `
    -reset_timestamps 1 `
    "$tempPartPattern"

# === STEP 4: Rename parts cleanly ===
Write-Host "`nRenaming parts..."

$files = Get-ChildItem "$serviceName\temp_part_*.mp4" | Sort-Object Name
$count = 1

foreach ($file in $files) {
    $newName = "Part $count.mp4"
    $destination = Join-Path -Path $serviceName -ChildPath $newName
    Rename-Item -Path $file.FullName -NewName $destination
    $count++
}

Write-Host "`nDone! Check the '$serviceName' folder for your compressed and split videos."
