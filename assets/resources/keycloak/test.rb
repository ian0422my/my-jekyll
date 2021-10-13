require 'base64'

value = "qnf0H8np9YDp3yal2ylEuM0I1aN_n-Blq-W-F2m9G1T25zR13ukjK2ud3PwNVRgFPJdQ3scMDLHhHrXPe8rMeg"
base64val = Base64.encode64(Base64.urlsafe_decode64(value))

puts base64val
