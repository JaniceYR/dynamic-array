def single_in_sorted(arr)
  # time o(log)
  # space o(1)
  p arr
  return arr[0] if arr.length <= 1
  mid = arr.length / 2

  if arr[mid] == arr[mid + 1]
    return single_in_sorted(arr[0...mid])
  else
    return single_in_sorted(arr[mid..-1])
  end
end

single_in_sorted([0,0,1,1,2,3,3])

def well_formed_string(arr)
  # {}[]()
  brackets = []
  dic = {'{' => '}'}

  arr.each_char do |char|
    if



end
