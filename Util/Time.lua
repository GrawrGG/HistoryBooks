local SECONDS_IN_HOUR = 3600
local SECONDS_IN_MINUTE = 60

function HBDurationToString(duration)
  local remainder = duration
  local hours = floor(remainder / SECONDS_IN_HOUR)
  remainder = remainder - hours * SECONDS_IN_HOUR
  local minutes = floor(remainder / SECONDS_IN_MINUTE)
  remainder = remainder - minutes * SECONDS_IN_MINUTE
  local seconds = remainder
  return format("%02d:%02d:%02d", hours, minutes, seconds)
end
