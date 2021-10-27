local M = {}

-- Generate array from file lines
function M.fileToArray( fpath )
  local file = io.open(fpath, 'r');
  local  arr = {}
  for line in file:lines() do
    table.insert(arr, line);
  end
  return arr
end

-- Check if number is prime
function M.is_prime(n)
  local max_divider_checked = math.sqrt(n) + 1
  for i = 2, max_divider_checked do
    if(n % i == 0) then
      return false
    end
  end
  return true
end

return M
