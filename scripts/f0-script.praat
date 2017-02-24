timeStep = 0.00390625
minimum_pitch = 75
maximum_pitch = 500
input_directory$ = "/path/to/wave/data/"
output_directory$ = "/path/to/f0_output/output/"
file_type$ = "wav"

fileList = do("Create Strings as file list...", "list", input_directory$ + "/*." + file_type$)
numberOfFiles = do("Get number of strings")

for i to numberOfFiles

  selectObject(fileList)
  filename$ = do$("Get string...", i)
  soundObject =  do("Read from file...", input_directory$ +"/" + filename$)

  pitchObject = do("To Pitch...", timeStep, minimum_pitch, maximum_pitch)
  removeObject(soundObject)
  tableObject = do("Create Table with column names...", "table", 0, 
      ..."time pitch")

  selectObject(pitchObject)
  numberOfFrames = do("Get number of frames")
  for frame to numberOfFrames

    select pitchObject
    f0 = do("Get value in frame...", frame, "Hertz")
    time = do("Get time from frame number...", frame)

    selectObject(tableObject)
    do("Append row")
    thisRow = do("Get number of rows")
    do("Set numeric value...", thisRow, "time", time)
    do("Set numeric value...", thisRow, "pitch", f0)

  endfor

  filename$ = filename$ - ("." + file_type$)
  do("Write to table file...", output_directory$ + "/" + filename$ + ".txt")
  removeObject(tableObject, pitchObject)
endfor
