# Copyright (c) 2010-2019 Jacob Hammack.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NON INFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module Risu
	module Templates
		module ScanHelper

			#
			# TODO doc
			def scan_info_to_hash plugin_output
				scan_info = {}

				plugin_output.split("\n").each do |line|
					a = line.split(":")

					if a.size != 2
						next
					end

					key = a[0].strip.downcase
					value = a[1].strip.downcase

					key = key.gsub(" ", "_")

					scan_info[key] = value
				end

				return scan_info
			end

			# TODO doc
			#
			def authenticated_count
				count = {}
				count["auth"] = 0
				count["unauth"] = 0

				Item.where(:plugin_id => 19506).each do |item|
					scan_info = scan_info_to_hash (item.plugin_output)

					auth = scan_info["credentialed_checks"]

					if auth =~ /yes/
						count["auth"] = count["auth"] + 1
					else
						count["unauth"] = count["unauth"] + 1
					end
				end

				return count
			end
		end
	end
end
