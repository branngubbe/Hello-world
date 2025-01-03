# PowerShell Script to Organize Photos by Month

# Define the folder containing the images
$sourceFolder = "C:\Users\brann\OneDrive\Pictures\Camera Roll"

# Define the target folder for organized photos
$targetFolder = "C:\Users\brann\OneDrive\Bilder 1\2024\mobilbilder"

# Define the log file
$logFile = "C:\Users\brann\OneDrive\Bilder 1\2024\mobilbilder\organize_log.txt"

# Ensure the source folder exists
if (!(Test-Path -Path $sourceFolder)) {
    Write-Host "Source folder does not exist: $sourceFolder" -ForegroundColor Red
    exit
}

# Ensure the target folder exists
if (!(Test-Path -Path $targetFolder)) {
    New-Item -Path $targetFolder -ItemType Directory | Out-Null
}

# Initialize the log file
if (Test-Path -Path $logFile) {
    Remove-Item -Path $logFile -Force
}
New-Item -Path $logFile -ItemType File | Out-Null

# Get all image and XMP files in the folder
$imageFiles = Get-ChildItem -Path $sourceFolder -Recurse -Include *.jpg, *.jpeg, *.png, *.bmp, *.gif, *.xmp, *.mp4

if ($imageFiles.Count -eq 0) {
    Write-Host "No image or XMP files found in the source folder." -ForegroundColor Yellow
    exit
}

# Loop through each file
foreach ($file in $imageFiles) {
    try {
        # Retrieve the date the photo was taken
        $photoDate = (Get-ItemProperty -Path $file.FullName).CreationTime

        # Format the date as Year-Month (e.g., 2025-01)
        $monthFolderName = $photoDate.ToString("yyyy-MM")

        # Create the folder for the month if it doesn't exist
        $monthFolderPath = Join-Path -Path $targetFolder -ChildPath $monthFolderName
        if (!(Test-Path -Path $monthFolderPath)) {
            New-Item -Path $monthFolderPath -ItemType Directory | Out-Null
        }

        # Move the file to the corresponding folder
        $destinationPath = Join-Path -Path $monthFolderPath -ChildPath $file.Name
        Move-Item -Path $file.FullName -Destination $destinationPath

        # Log the file movement
        $logEntry = "Moved file: $($file.FullName) -> $destinationPath"
        Add-Content -Path $logFile -Value $logEntry

        Write-Host $logEntry -ForegroundColor Green
    }
    catch {
        Write-Host "Error processing file: $($file.Name) - $_" -ForegroundColor Red
        $errorEntry = "Error processing file: $($file.FullName) - $_"
        Add-Content -Path $logFile -Value $errorEntry
    }
}

Write-Host "Photo organization complete. Log file created at $logFile" -ForegroundColor Cyan
