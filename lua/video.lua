-- recording
do
    local recording = false

    function startRecording()
        recording = true
    end

    function stopRecording()
        recording = false
    end

    function isRecording()
        return recording
    end
end
