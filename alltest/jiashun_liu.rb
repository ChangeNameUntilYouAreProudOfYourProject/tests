require 'minitest/autorun'
require './cs253Array.rb'
require './triple.rb'

class CS253EnumTests < Minitest::Test
    def test_all
        str_all = CS253Array.new(['cat', 'dog', 'duck'])
        int_all = CS253Array.new([1, 2, 3])
        str_all_two = CS253Array.new(["string", "anotherString", "lastString"])
        triple = Triple.new(3,4,5)

        assert_equal str_all.cs253all?{|word| word.length >= 4 }.to_s, "false"
        assert_equal int_all.cs253all?{|i| i < 4}.to_s, "true"
        assert_equal str_all_two.cs253all?{|word| word.length >= 4}.to_s,"true"
        assert_equal triple.cs253all?{|i| i > 2}.to_s, "true"
    end

    def test_any
        str_any = CS253Array.new(['cat', 'dog', 'duck'])
        int_any = CS253Array.new([1, 2, 3])
        str_any_two = CS253Array.new(["string", "anotherString", "lastString"])
        triple = Triple.new(3,4,5)

        assert_equal str_any.cs253any?{|word| word.length >= 4 }.to_s, "true"
        assert_equal int_any.cs253any?{|i| i < 4}.to_s, "true"
        assert_equal str_any_two.cs253any?{|word| word.length < 4}.to_s,"false"
        assert_equal triple.cs253any?{|i| i > 5}.to_s, "false"
    end

    def test_chunk
        str_chunk = CS253Array.new(['cat', 'dog', 'duck', 'bee', 'panda'])
        int_chunk = CS253Array.new([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5])
        str_chunk_two = CS253Array.new(["string", "anotherString", "lastString"])
        triple = Triple.new(3,4,5)

        assert_equal str_chunk.cs253chunk{|word| word.length}.to_a, [[3, ["cat", "dog"]], [4, ["duck"]], [3, ["bee"]], [5, ["panda"]]]
        assert_equal int_chunk.cs253chunk{|n| n.even?}.to_a, [[false, [3, 1]], [true, [4]], [false, [1, 5, 9]], [true, [2, 6]], [false, [5, 3, 5]]]
        assert_equal str_chunk_two.cs253chunk{|word| word.length < 7}.to_a,[[true, ["string"]], [false, ["anotherString", "lastString"]]]
        assert_equal triple.cs253chunk{|i| i > 5}.to_a,[[false, [3, 4, 5]]]
    end

    def test_chunk_while
        int_chunk_while_equal = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21])
        int_chunk_while_small = CS253Array.new([0, 9, 2, 2, 3, 2, 7, 5, 9, 5])
        int_chunk_while_even = CS253Array.new([7, 5, 9, 2, 0, 7, 9, 4, 2, 0])
        triple = Triple.new(1,3,4)

        assert_equal int_chunk_while_equal.cs253chunk_while{|i, j| i+1 == j }.to_a, [[1, 2], [4], [9, 10, 11, 12], [15, 16], [19, 20, 21]]
        assert_equal int_chunk_while_small.cs253chunk_while{|i, j| i <= j }.to_a, [[0, 9], [2, 2, 3], [2, 7], [5, 9], [5]]
        assert_equal int_chunk_while_even.cs253chunk_while{|i, j| i.even? == j.even? }.to_a, [[7, 5, 9], [2, 0], [7, 9], [4, 2, 0]]
        assert_equal triple.cs253chunk_while{|i,j| j-i > 1}.to_a,[[1, 3], [4]]
    end

    def test_collect
        int_collect = CS253Array.new([1, 2, 3])
        str_collect = CS253Array.new(["string", "anotherString", "lastString"])
        int_collect_two = CS253Array.new([1,2,3,4])
        triple = Triple.new(1,3,4)

        assert_equal int_collect.cs253collect{|i| 10*i}.to_a,[10, 20, 30]
        assert_equal str_collect.cs253collect{|i| i.length}.to_a,[6,13,10]
        assert_equal int_collect_two.cs253collect{"cat"}.to_a, ['cat','cat','cat','cat']
        assert_equal triple.cs253collect{|i| 10*i}.to_a,[10,30,40]
    end

    def test_collect_concat
        int_collect_concat = CS253Array.new([1, 2, 3, 4])
        arr_collect_concat = CS253Array.new([[1,2,3],[4,5,6,7],[8,9,10,11]])
        str_collect_concat_two = CS253Array.new(['cat','dog','duck'])
        triple = Triple.new(1,3,4)

        assert_equal int_collect_concat.cs253collect_concat{ |e| [e,-e] }.to_a,[1, -1, 2, -2, 3, -3, 4, -4]
        assert_equal arr_collect_concat.cs253collect_concat{|e| e + [e.length]}.to_a,[1,2,3,3,4,5,6,7,4,8,9,10,11,4]
        assert_equal str_collect_concat_two.cs253collect_concat{ |e| [e, e.length] }.to_a,["cat", 3, "dog", 3, "duck", 4]
        assert_equal triple.cs253collect_concat{|e| [e,-e]}.to_a,[1,-1,3,-3,4,-4]
    end

    def test_count
        int_count = CS253Array.new([1,2,3,4,5,6])
        str_count = CS253Array.new(["cat", "dog", "duck"])
        arr_count = CS253Array.new([[1,2,3], [4,5,6,7],[6,8]])
        triple = Triple.new(1,3,4)

        assert_equal int_count.cs253count{ |e| e.even? }.to_i, 3
        assert_equal str_count.cs253count{ |e| e.length > 4}.to_i,0
        assert_equal arr_count.cs253count{ |e| e[0].even? }.to_i,2
        assert_equal triple.cs253count{|e| e > 3}.to_i,1
    end

    def test_cycle
        int_arr = CS253Array.new()
        arr_arr = CS253Array.new()
        str_arr = CS253Array.new()
        trp_arr = CS253Array.new()

        int_cycle = CS253Array.new([1,2,3])
        arr_cycle = CS253Array.new([[1,2,3],[4,5,6],[7,8,9]])
        str_cycle = CS253Array.new(['cat','dog','duck'])
        triple = Triple.new(1,3,4)

        int_cycle.cs253cycle(3){|i| int_arr << 10*i}
        arr_cycle.cs253cycle(2){|i| arr_arr << i[0]}
        str_cycle.cs253cycle(3){|i| str_arr << i}
        triple.cs253cycle(2){|i| trp_arr << 10*i}

        assert_equal int_arr.to_a, [10,20,30,10,20,30,10,20,30]
        assert_equal arr_arr.to_a, [1,4,7,1,4,7]
        assert_equal str_arr.to_a, ['cat','dog','duck','cat','dog','duck','cat','dog','duck']
        assert_equal trp_arr.to_a, [10,30,40,10,30,40]
    end

    def test_detect
        int_detect = CS253Array.new([1,2,3,4,5,6,7,8,9,10])
        int_detect_two = CS253Array.new([1,2,3,4,5,6])
        str_detect = CS253Array.new(['cat', 'dog', 'duck'])
        triple = Triple.new(1,3,4)

        assert_equal int_detect.cs253detect{|e| e % 5 == 0 and e % 7 == 0}.to_s, ""
        assert_equal int_detect_two.cs253detect{|e| e.even?}.to_i, 2
        assert_equal str_detect.cs253detect{|e| e.length > 3}.to_s, 'duck'
        assert_equal triple.cs253detect{|e| e > 3}.to_i,4
    end

    def test_drop
        int_drop_zero = CS253Array.new([1,2,3,4,5,6])
        int_drop_two = CS253Array.new([1,2,3,4,5,6])
        int_drop_all = CS253Array.new([1,2,3,4,5,6])
        triple = Triple.new(1,3,4)

        assert_equal int_drop_zero.cs253drop(0).to_a, [1,2,3,4,5,6]
        assert_equal int_drop_two.cs253drop(2).to_a, [3,4,5,6]
        assert_equal int_drop_all.cs253drop(7).to_a, []
        assert_equal triple.cs253drop(2).to_a,[4]
    end

    def test_drop_while
        int_drop_while = CS253Array.new([1,2,3,4,0])
        str_drop_while = CS253Array.new(['cat', 'dog', 'duck', 'bee'])
        arr_drop_while = CS253Array.new([[2,5,6],[4,7,10],[2,4,11],[5,3,8]])
        triple = Triple.new(1,3,4)

        assert_equal int_drop_while.cs253drop_while{|e| e < 3}.to_a, [3,4,0]
        assert_equal str_drop_while.cs253drop_while{|e| e.length < 4}.to_a, ['duck', 'bee']
        assert_equal arr_drop_while.cs253drop_while{|e| (e[-1] - e[0]) < 5}.to_a, [[4,7,10],[2,4,11],[5,3,8]]
        assert_equal triple.cs253drop_while{|i| i<3}.to_a,[3,4]
    end

    def test_each_cons
        int_arr = CS253Array.new()
        int_arr_two = CS253Array.new()
        str_arr = CS253Array.new()
        trp_arr = CS253Array.new()

        int_each_cons = CS253Array.new([1,2,3,4,5,6,7,8,9,10])
        int_each_cons_two = CS253Array.new([1,2,3,4,5,6,7,8,9,10])
        str_each_cons = CS253Array.new(['cat','dog','duck','mouse','pig'])
        triple = Triple.new(1,3,4)

        int_each_cons.cs253each_cons(3){|a| int_arr.push(a)}
        int_each_cons_two.cs253each_cons(5){|a| int_arr_two.push(a)}
        str_each_cons.cs253each_cons(2){|a| str_arr.push(a)}
        triple.cs253each_cons(2){|i| trp_arr.push(i)}

        assert_equal int_arr.to_a, [[1, 2, 3],[2, 3, 4],[3, 4, 5],[4, 5, 6],[5, 6, 7],[6, 7, 8],[7, 8, 9],[8, 9, 10]]
        assert_equal int_arr_two.to_a, [[1, 2, 3, 4, 5], [2, 3, 4, 5, 6], [3, 4, 5, 6, 7], [4, 5, 6, 7, 8], [5, 6, 7, 8, 9], [6, 7, 8, 9, 10]]
        assert_equal str_arr.to_a, [["cat", "dog"], ["dog", "duck"], ["duck", "mouse"], ["mouse", "pig"]]
        assert_equal trp_arr.to_a, [[1,3],[3,4]]
    end

    def test_each_entry
        int_each_entry = CS253Array.new([1,2,3])
        str_each_entry = CS253Array.new(['cat', 'dog', 'duck'])
        arr_each_entry = CS253Array.new([[1,2,3],[4,5,6],[7,8,9]])
        triple = Triple.new(1,3,4)

        assert_equal int_each_entry.cs253each_entry{|e| 10*e}.to_a, [1,2,3]
        assert_equal str_each_entry.cs253each_entry{|e| e.length}.to_a, ['cat', 'dog', 'duck']
        assert_equal arr_each_entry.cs253each_entry{|e| e}.to_a,[[1,2,3],[4,5,6],[7,8,9]]
        assert_equal triple.cs253each_entry{|i|  i<3}.to_a,[1,3,4]
    end

    def test_each_slice
        int_arr = CS253Array.new()
        int_arr_two = CS253Array.new()
        str_arr = CS253Array.new()
        trp_arr = CS253Array.new()

        int_each_slice = CS253Array.new([1,2,3,4,5,6,7,8,9,10])
        int_each_slice_two = CS253Array.new([1,2,3,4,5,6,7,8,9,10])
        str_each_slice = CS253Array.new(['cat','dog','duck','mouse','pig'])
        triple = Triple.new(1,3,4)

        int_each_slice.cs253each_slice(3){|a| int_arr.push(a)}
        int_each_slice_two.cs253each_slice(5){|a| int_arr_two.push(a)}
        str_each_slice.cs253each_slice(2){|a| str_arr.push(a)}
        triple.cs253each_slice(2){|a| trp_arr.push(a)}

        assert_equal int_arr.to_a, [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]]
        assert_equal int_arr_two.to_a, [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]]
        assert_equal str_arr.to_a, [["cat", "dog"], ["duck", "mouse"], ["pig"]]
        assert_equal trp_arr.to_a, [[1,3], [4]]
    end

    def test_each_with_index
        hash_int = Hash.new()
        hash_arr = Hash.new()
        hash_str = Hash.new()
        hash_trp = Hash.new()

        int_each_with_index = CS253Array.new([1,3,5,7,9])
        arr_each_with_index = CS253Array.new([[1,2,3],[4,5,6,7],[8,9,10,11,12]])
        str_each_with_index = CS253Array.new(["apple", "pear", "banana"])
        triple = Triple.new(1,3,4)

        int_each_with_index.cs253each_with_index{|i, index| hash_int[i] = index}
        arr_each_with_index.cs253each_with_index{|arr, index| hash_arr[arr.length] = arr}
        str_each_with_index.cs253each_with_index{|i,index| hash_str[i[0]] = i}
        triple.cs253each_with_index{|i,index| hash_trp[i] = index}

        assert_equal hash_int.to_h, {1=>0, 3=>1, 5=>2, 7=>3, 9=>4}
        assert_equal hash_arr.to_h, {3=>[1, 2, 3], 4=>[4, 5, 6, 7], 5=>[8, 9, 10, 11, 12]}
        assert_equal hash_str.to_h, {"a"=>"apple", "p"=>"pear", "b"=>"banana"}
        assert_equal hash_trp.to_h, {1=>0,3=>1, 4=>2}
    end

    def test_each_with_object
        int_each_with_object = CS253Array.new([1,2,3,4,5,6,7,8,9,10])
        arr_each_with_object = CS253Array.new([[1,2,3],[4,5,6],[7,8,9]])
        str_each_with_object = CS253Array.new(["cat",'dog',"panda"])
        triple = Triple.new(1,3,4)

        assert_equal int_each_with_object.each_with_object([]) { |i, a| a << i*2 }.to_a, [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
        assert_equal arr_each_with_object.each_with_object([]) {|i, a| a << i.length}.to_a, [3,3,3]
        assert_equal str_each_with_object.each_with_object([]) {|i, a| a << i[0]}.to_a, ["c","d","p"]
        assert_equal triple.cs253each_with_object([]){|i,a| a << i}.to_a, [1,3,4]
    end

    def test_entries
        int_entries = CS253Array.new([1,2,3,4,5])
        arr_entries = CS253Array.new([[1,2,3],[4,5,6]])
        str_entries = CS253Array.new(["cat","dog","duck"])
        triple = Triple.new(1,3,4)

        assert_equal int_entries.cs253entries.to_a, [1,2,3,4,5]
        assert_equal arr_entries.cs253entries.to_a, [[1, 2, 3], [4, 5, 6]]
        assert_equal str_entries.cs253entries.to_a, ["cat","dog","duck"]
        assert_equal triple.cs253entries.to_a, [1,3,4]
    end

    def test_find
        int_find = CS253Array.new([1,2,3,4,5])
        arr_find = CS253Array.new([[1,2,3],[2,3,4],[3,4,5]])
        int_find_two = CS253Array.new([1,2,3,4,5])
        triple = Triple.new(1,3,4)

        assert_equal int_find.cs253find{|i| i > 3}.to_i, 4
        assert_equal arr_find.cs253find{|i| i[-1] > 5}.to_s, ""
        assert_equal int_find_two.cs253find{|i| i > 6}.to_s, ""
        assert_equal triple.cs253find{|i| i > 6}.to_s, ""
    end

    def test_find_all
        int_find_all = CS253Array.new([1,2,3,4,5,6,7,8,9])
        arr_find_all = CS253Array.new([[2,4,6],[1,3,5],[7,9,8]])
        str_find_all = CS253Array.new(['cat', 'dog','duck'])
        triple = Triple.new(1,3,4)

        assert_equal int_find_all.cs253find_all {|i|  i % 3 == 0 }.to_a, [3,6,9]
        assert_equal arr_find_all.cs253find_all {|i| (i[-1]-i[0]) > 3}.to_a, [[2,4,6],[1,3,5]]
        assert_equal str_find_all.cs253find_all {|i| i.length > 5}.to_a, []
        assert_equal triple.cs253find_all{|i| i > 1}.to_a, [3,4]

    end

    def test_find_index
        int_find_index = CS253Array.new([1,2,3,4,5])
        arr_find_index = CS253Array.new([[1,2,3],[2,3,4],[3,4,5]])
        int_find_index_two = CS253Array.new([1,2,3,4,5])
        triple = Triple.new(1,3,4)

        assert_equal int_find_index.cs253find_index{|i| i > 3}.to_i, 3
        assert_equal arr_find_index.cs253find_index{|i| i[-1] > 4}.to_i, 2
        assert_equal int_find_index_two.cs253find_index{|i| i > 6}.to_s, ""
        assert_equal triple.cs253find_index{|i| i > 1}.to_i, 1
    end

    def test_first
        int_first = CS253Array.new([1,2,3,4,5])
        str_first = CS253Array.new(['cat','dog','duck'])
        int_first_two = CS253Array.new([])
        triple = Triple.new(1,3,4)

        assert_equal int_first.cs253first(4).to_a, [1,2,3,4]
        assert_equal str_first.cs253first(4).to_a, ['cat','dog','duck']
        assert_equal int_first_two.cs253first(10).to_a, []
        assert_equal triple.cs253first(4).to_a, [1,3,4]
    end

    def test_flat_map
        int_flat_map = CS253Array.new([1, 2, 3, 4])
        arr_flat_map = CS253Array.new([[1,2,3],[4,5,6,7],[8,9,10,11]])
        str_flat_map_two = CS253Array.new(['cat','dog','duck'])
        triple = Triple.new(1,3,4)

        assert_equal int_flat_map.cs253flat_map{ |e| [e,-e] }.to_a,[1, -1, 2, -2, 3, -3, 4, -4]
        assert_equal arr_flat_map.cs253flat_map{|e| e + [e.length]}.to_a,[1,2,3,3,4,5,6,7,4,8,9,10,11,4]
        assert_equal str_flat_map_two.cs253flat_map{ |e| [e, e.length] }.to_a,["cat", 3, "dog", 3, "duck", 4]
        assert_equal triple.cs253flat_map{|e| [e,-e]}.to_a,[1,-1,3,-3,4,-4]
    end

    def test_grep
        str_grep = CS253Array.new(['bear','cat','dog'])
        str_grep_two = CS253Array.new(["apple", "application", "banana"])
        str_grep_three = CS253Array.new(['abcd','abdc','acdb'])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253grep(3..4){|i| i*2}.to_a,[6,8]
        assert_equal str_grep.cs253grep(/a/){ |v| v.length }.to_a, [4,3]
        assert_equal str_grep_two.cs253grep(/app/){|str| str.length}.to_a, [5,11]
        assert_equal str_grep_three.cs253grep(/cb/){ |v| v}.to_a, []
    end

    def test_grep_v
        str_grep = CS253Array.new(["apple", "application", "banana",'pear'])
        str_grep_two = CS253Array.new(["apple", "application", "banana"])
        str_grep_three = CS253Array.new(["apple", "application", "banana"])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253grep_v(3..4){|i| i*2}.to_a,[10]
        assert_equal str_grep.cs253grep_v(/app/){|str| str.length}.to_a, [6,4]
        assert_equal str_grep_two.cs253grep_v(/app/){|str| str}.to_a, ["banana"]
        assert_equal str_grep_three.cs253grep_v(/app/){|str| str[0]}.to_a, ["b"]
    end

    def test_group_by
        str_group_by = CS253Array.new(['cat','dog','duck','pig','mouse'])
        int_group_by = CS253Array.new([1,2,3,4,5,6])
        even_group_by = CS253Array.new([1,2,3,4,5,6])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253group_by{|i| i.even?}.to_h,{false=>[3, 5], true=>[4]}
        assert_equal str_group_by.cs253group_by{|i| i.length}.to_h, {3=>["cat", "dog", "pig"], 4=>["duck"], 5=>["mouse"]}
        assert_equal int_group_by.cs253group_by{|i| i % 3}.to_h, {1=>[1, 4], 2=>[2, 5], 0=>[3, 6]}
        assert_equal even_group_by.cs253group_by{|i| i.even?}.to_h, {false=>[1, 3, 5], true=>[2, 4, 6]}
    end

    def test_include?
        io_include = CS253Array.new(IO.constants)
        io_include_two = CS253Array.new(IO.constants)
        int_include = CS253Array.new([2,3,4,5,6])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253include?(3).to_s,"true"
        assert_equal io_include.cs253include?(:SEEK_SET).to_s, "true"
        assert_equal io_include.cs253include?(:SEEK_NO_FURTHER).to_s, "false"
        assert_equal int_include.cs253include?(2).to_s, "true"
    end

    def test_inject
        int_inject = CS253Array.new([3,5,2])
        int_inject_arg = CS253Array.new([3,5,2])
        str_inject = CS253Array.new(["Liu", "is", "my", "last name"])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253inject{|product, n| product * n}.to_i,60
        assert_equal int_inject.cs253inject{|product, n| product * n}.to_i, 30
        assert_equal int_inject_arg.cs253inject(3){|product, n| product * n}.to_i, 90
        assert_equal str_inject.cs253inject{|str1, str2| str1 + " " + str2}.to_s, "Liu is my last name"
    end

    def test_map
        int_map = CS253Array.new([1, 2, 3])
        str_map= CS253Array.new(["string", "anotherString", "lastString"])
        int_map_two = CS253Array.new([1,2,3,4])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253map{|i|3*i}.to_a,[9,15,12]
        assert_equal int_map.cs253map{|i| 10*i}.to_a,[10, 20, 30]
        assert_equal str_map.cs253map{|i| i.length}.to_a,[6,13,10]
        assert_equal int_map_two.cs253map{"cat"}.to_a, ['cat','cat','cat','cat']
    end

    def test_max
        str_max = CS253Array.new(['albatross', 'albatross', 'dog', 'horse'])
        str_max_two = CS253Array.new(['albatross', 'albatross', 'dog', 'horse'])
        str_max_three = CS253Array.new(['albatross', 'albatross', 'dog', 'horse'])
        triple_test= Triple.new('albatross', 'dog', 'horse')

        assert_equal triple_test.cs253max(1){|i,j| i.length<=>j.length}.to_a,["albatross"]
        assert_equal str_max.cs253max(5) {|a, b| a.length <=> b.length }.to_a, ["albatross", "albatross", "horse", "dog"]
        assert_equal str_max_two.cs253max(3) {|a, b| a.length <=> b.length }.to_a, ["albatross", "albatross", "horse"]
        assert_equal str_max_three.cs253max(1) {|a, b| a.length <=> b.length }.to_a, ["albatross"]
    end

    def test_max_by
        str_max_by = CS253Array.new(['albatross', 'albatross', 'dog', 'horse'])
        str_max_by_two = CS253Array.new(['albatross', 'albatross', 'dog', 'horse'])
        str_max_by_three = CS253Array.new(['albatross', 'albatross', 'dog', 'horse'])
        triple_test= Triple.new('albatross', 'dog', 'horse')

        assert_equal triple_test.cs253max_by(1){|i| i.length}.to_a,["albatross"]
        assert_equal str_max_by.cs253max_by(5) {|a| a.length}.to_a, ["albatross", "albatross", "horse", "dog"]
        assert_equal str_max_by_two.cs253max_by(3) {|a| a.length}.to_a, ["albatross", "albatross", "horse"]
        assert_equal str_max_by_three.cs253max_by(1) {|a| a.length}.to_a, ["albatross"]
    end

    def test_member?
        io_member = CS253Array.new(IO.constants)
        io_member_two = CS253Array.new(IO.constants)
        int_member = CS253Array.new([2,3,4,5,6])
        triple_test= Triple.new('albatross', 'dog', 'horse')

        assert_equal triple_test.cs253member?('dog').to_s,"true"
        assert_equal io_member.cs253member?(:SEEK_SET).to_s, "true"
        assert_equal io_member.cs253member?(:SEEK_NO_FURTHER).to_s, "false"
        assert_equal int_member.cs253member?(2).to_s, "true"
    end

    def test_min
        str_min = CS253Array.new(['albatross', 'albatross', 'dog', 'horse'])
        str_min_two = CS253Array.new(['albatross', 'albatross', 'dog', 'horse'])
        str_min_three = CS253Array.new(['albatross', 'albatross', 'dog', 'horse'])
        triple_test= Triple.new('albatross', 'dog', 'horse')

        assert_equal triple_test.cs253min(1){|i,j| i.length<=>j.length}.to_a,["dog"]
        assert_equal str_min.cs253min(5) {|a, b| a.length <=> b.length }.to_a, ["dog", "horse", "albatross", "albatross"]
        assert_equal str_min_two.cs253min(3) {|a, b| a.length <=> b.length }.to_a, ["dog", "horse", "albatross"]
        assert_equal str_min_three.cs253min(1) {|a, b| a.length <=> b.length }.to_a, ["dog"]
    end

    def test_min_by
        str_min_by = CS253Array.new(['albatross', 'albatross', 'dog', 'horse'])
        str_min_by_two = CS253Array.new(['albatross', 'albatross', 'dog', 'horse'])
        str_min_by_three = CS253Array.new(['albatross', 'albatross', 'dog', 'horse'])
        triple_test= Triple.new('albatross', 'dog', 'horse')

        assert_equal triple_test.cs253min_by(1){|i| i.length}.to_a,["dog"]
        assert_equal str_min_by.cs253min_by(5) {|a| a.length}.to_a, ["dog", "horse", "albatross", "albatross"]
        assert_equal str_min_by_two.cs253min_by(3) {|a| a.length}.to_a, ["dog", "horse", "albatross"]
        assert_equal str_min_by_three.cs253min_by(1) {|a| a.length}.to_a, ["dog"]
    end

    def test_minmax
        str_minmax = CS253Array.new(['albatross', 'albatross', 'dog', 'horse'])
        int_minmax = CS253Array.new([1,2,3,4,5])
        arr_minmax = CS253Array.new([[1,2,3],[2,3,4],[3,4,5]])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253minmax{|i,j| i<=>j}.to_a,[3,5]
        assert_equal str_minmax.cs253minmax{|a, b| a.length <=> b.length }.to_a, ["dog", "albatross"]
        assert_equal int_minmax.cs253minmax{|a, b| a <=> b}.to_a, [1,5]
        assert_equal arr_minmax.cs253minmax{|a, b| a[0]<=> b[0] }.to_a, [[1,2,3],[3,4,5]]
    end

    def test_minmiax_by
        str_minmax_by = CS253Array.new(['albatross', 'albatross', 'dog', 'horse'])
        int_minmax_by = CS253Array.new([1,2,3,4,5])
        arr_minmax_by = CS253Array.new([[1,2,3],[2,3,4],[3,4,5]])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253minmax_by{|n| n}.to_a,[3,5]
        assert_equal str_minmax_by.cs253minmax_by{|a| a.length}.to_a, ["dog", "albatross"]
        assert_equal int_minmax_by.cs253minmax_by{|a| a}.to_a, [1,5]
        assert_equal arr_minmax_by.cs253minmax_by{|a| a[0]}.to_a, [[1,2,3],[3,4,5]]
    end

    def test_none?
        int_none = CS253Array.new([1,3,5,7])
        str_none = CS253Array.new(['ant', 'bear', 'cat'])
        arr_none = CS253Array.new([[1,2,3],[4,5,6,7],[8,9,10,11,12]])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253none?{|n| n>3}.to_s,"false"
        assert_equal int_none.cs253none?{|i| i.even?}.to_s, "true"
        assert_equal str_none.cs253none?{|i| i.length > 3}.to_s, "false"
        assert_equal arr_none.cs253none?{|i| i.length > 6}.to_s, "true"
    end

    def test_one?
        int_one = CS253Array.new([1,3,5,7])
        str_one = CS253Array.new(['ant', 'bear', 'cat'])
        arr_one = CS253Array.new([[1,2,3],[4,5,6,7],[8,9,10,11,12]])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253one?{|n| n>3}.to_s,"false"
        assert_equal int_one.cs253one?{|i| i.even?}.to_s, "false"
        assert_equal str_one.cs253one?{|i| i.length > 3}.to_s, "true"
        assert_equal arr_one.cs253one?{|i| i.length > 6}.to_s, "false"
    end

    def test_partition
        str_partition = CS253Array.new(['apple', 'ban', 'orange'])
        int_partition = CS253Array.new([1,2,3,4,5,6])
        arr_partition = CS253Array.new([[1,2,3],[1,3,4],[2,3,4],[4,5,6]])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253partition{|n| n>3}.to_a,[[5,4],[3]]
        assert_equal str_partition.cs253partition{|a| a.length > 4}.to_a, [["apple", "orange"], ["ban"]]
        assert_equal int_partition.cs253partition{|a| a.even?}.to_a, [[2, 4, 6], [1, 3, 5]]
        assert_equal arr_partition.cs253partition{|a| a[0] > 1}.to_a, [[[2, 3, 4], [4, 5, 6]], [[1, 2, 3], [1, 3, 4]]]
    end

    def test_reduce
        int_reduce = CS253Array.new([3,5,2])
        int_reduce_arg = CS253Array.new([3,5,2])
        str_reduce = CS253Array.new(["Liu", "is", "my", "last name"])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253reduce{|product, n| product * n}.to_i,60
        assert_equal int_reduce.cs253reduce{|product, n| product * n}.to_i, 30
        assert_equal int_reduce_arg.cs253reduce(3){|product, n| product * n}.to_i, 90
        assert_equal str_reduce.cs253reduce{|str1, str2| str1 + " " + str2}.to_s, "Liu is my last name"
    end

    def test_reject
        int_reject = CS253Array.new([1,2,3,4,5,6,7,8,9])
        arr_reject = CS253Array.new([[2,4,6],[1,3,5],[7,9,8]])
        str_reject = CS253Array.new(['cat', 'dog','duck'])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253reject{ |a| a.odd? }.to_a,[4]
        assert_equal int_reject.cs253reject {|i|  i % 3 == 0 }.to_a, [1,2,4,5,7,8]
        assert_equal arr_reject.cs253reject {|i| (i[-1]-i[0]) > 3}.to_a, [[7,9,8]]
        assert_equal str_reject.cs253reject {|i| i.length > 5}.to_a, ['cat', 'dog','duck']
    end

    def test_reverse_each
        int_reverse = CS253Array.new([1,2,3,4,5,6,7,8,9])
        str_reverse = CS253Array.new(['cat', 'dog','duck'])
        arr_reverse = CS253Array.new([[2,4,6],[1,3,5],[7,9,8]])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253reverse_each{ |a| a }.to_a,[3,5,4]
        assert_equal int_reverse.cs253reverse_each{|i| 10*i}.to_a, [1,2,3,4,5,6,7,8,9]
        assert_equal str_reverse.cs253reverse_each{|i| i}.to_a, ['cat', 'dog','duck']
        assert_equal arr_reverse.cs253reverse_each{|i| i[0] + i[-1]},[[2,4,6],[1,3,5],[7,9,8]]
    end

    def test_select
        int_select_bigger = CS253Array.new([2,3,4,5,6])
        int_select_even = CS253Array.new([5,7,8,9])
        str_select = CS253Array.new(['apple', 'banana', 'orange', 'application'])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253select{ |a| a>=4 }.to_a,[5,4]
        assert_equal int_select_bigger.cs253select{|num| num > 3}.to_a, [4,5,6]
        assert_equal int_select_even.cs253select{|num| num.even?}.to_a, [8]
        assert_equal str_select.cs253select{|str| str.include?'app'}.to_a, ['apple', 'application']
    end

    def test_slice_after
        int_slice_after = CS253Array.new([1,2,3,4,7,5,8])
        str_slice_after = CS253Array.new(['cat','dog','mouse','pig'])
        arr_slice_after = CS253Array.new([[2,4,6],[1,3,5],[7,9,8]])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253slice_after{ |a| a>4 }.to_a,[[3,5],[4]]
        assert_equal int_slice_after.cs253slice_after { |elt| elt.even? }.to_a, [[1, 2], [3, 4], [7, 5, 8]]
        assert_equal str_slice_after.cs253slice_after {|str| str.length > 3}.to_a, [["cat", "dog", "mouse"], ["pig"]]
        assert_equal arr_slice_after.cs253slice_after {|i| (i[-1]-i[0]) > 3}.to_a, [[[2, 4, 6]], [[1, 3, 5]], [[7, 9, 8]]]
    end

    def test_slice_before
        int_slice_before = CS253Array.new([1,2,3,4,7,5,8])
        str_slice_before = CS253Array.new(['cat','dog','mouse','pig','bee'])
        arr_slice_before = CS253Array.new([[2,4,6],[1,3,5],[7,9,8]])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253slice_before{ |a| a>4 }.to_a,[[3],[5,4]]
        assert_equal int_slice_before.cs253slice_before { |elt| elt.even? }.to_a, [[1], [2, 3], [4, 7, 5], [8]]
        assert_equal str_slice_before.cs253slice_before {|str| str.length > 3}.to_a, [["cat", "dog"], ["mouse", "pig", "bee"]]
        assert_equal arr_slice_before.cs253slice_before {|i| (i[-1]-i[0]) > 3}.to_a, [[[2, 4, 6]], [[1, 3, 5], [7, 9, 8]]]
    end

    def test_slice_when
        int_slice_when = CS253Array.new([3, 11, 14, 25, 28, 29, 29, 41, 55, 57])
        int_slice_when_two = CS253Array.new([1,2,4,9,10,11,12,15,16,19,20,21])
        int_slice_when_three = CS253Array.new([0, 9, 2, 2, 3, 2, 7, 5, 9, 5])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253slice_when{ |a, b| b-a>1 }.to_a,[[3],[5,4]]
        assert_equal int_slice_when.cs253slice_when{|i, j| 6 < j - i }.to_a, [[3], [11, 14], [25, 28, 29, 29], [41], [55, 57]]
        assert_equal int_slice_when_two.cs253slice_when{|i, j| i+1 != j }.to_a, [[1, 2], [4], [9, 10, 11, 12], [15, 16], [19, 20, 21]]
        assert_equal int_slice_when_three.cs253slice_when{|i, j| i > j }.to_a, [[0, 9], [2, 2, 3], [2, 7], [5, 9], [5]]
    end

    def test_sort
        int_sort = CS253Array.new([1,2,3,4,5,6,7,8,9,10])
        int_sort_two = CS253Array.new([1,2,3,4,5,6,7,8,9,10])
        str_sort = CS253Array.new(['cat','dog','mouse','pig','bee'])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253sort{ |a, b| a <=> b }.to_a,[3,4,5]
        assert_equal int_sort.cs253sort{ |a, b| b <=> a }.to_a, [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        assert_equal int_sort_two.cs253sort{ |a, b| a <=> b }.to_a, [1,2,3,4,5,6,7,8,9,10]
        assert_equal str_sort.cs253sort{|a,b| a[0]<=>b[0]}.to_a, ["bee", "cat", "dog", "mouse", "pig"]
    end

    def test_sort_by
        str_sort_by = CS253Array.new(['apple','pear','fig'])
        int_sort_by = CS253Array.new([2,1,5,3,7,4])
        arr_sort_by = CS253Array.new([[1,2],[3,3],[1,4]])
        triple_test= Triple.new(3,5,4)

        assert_equal triple_test.cs253sort_by{|i|i}.to_a,[3,4,5]
        assert_equal str_sort_by.cs253sort_by{ |word| word.length }.to_a,["fig", "pear", "apple"]
        assert_equal int_sort_by.cs253sort_by{|i| i}.to_a, [1, 2, 3, 4, 5, 7]
        assert_equal arr_sort_by.cs253sort_by{|arr| arr[0] + arr[1]}.to_a, [[1, 2], [1, 4], [3, 3]]
    end

    def test_sum
        int_sum = CS253Array.new([1,2,3])
        int_sum_two = CS253Array.new([1,2,3])
        str_sum = CS253Array.new(['cat','dog','duck'])
        triple_test= Triple.new(3,4,5)

        assert_equal triple_test.cs253sum{|i|i}.to_i,12
        assert_equal int_sum.cs253sum{|i| i}.to_i, 6
        assert_equal int_sum_two.cs253sum{|i| 10*i}.to_i, 60
        assert_equal str_sum.cs253sum{|str| str.length}.to_i, 10
    end

    def test_take
        int_take = CS253Array.new([1,2,3,4,5])
        str_take = CS253Array.new(['cat','dog','duck'])
        int_take_two = CS253Array.new([])
        triple_test= Triple.new(3,4,5)

        assert_equal triple_test.cs253take(2){|i|i>2}.to_a,[3,4]
        assert_equal int_take.cs253take(4).to_a, [1,2,3,4]
        assert_equal str_take.cs253take(4).to_a, ['cat','dog','duck']
        assert_equal int_take_two.cs253take(10).to_a, []
    end

    def test_take_while
        int_take_while = CS253Array.new([1,2,3,4,5,0])
        str_take_while = CS253Array.new(['cat','dog','duck'])
        int_take_while_two = CS253Array.new([2,4,5,6])
        triple_test= Triple.new(3,4,5)

        assert_equal triple_test.cs253take_while{|i|i>2}.to_a,[3,4,5]
        assert_equal int_take_while.cs253take_while{|i| i < 3}.to_a, [1,2]
        assert_equal str_take_while.cs253take_while{|i| i.length > 3}.to_a, []
        assert_equal int_take_while_two.cs253take_while{|i| i.even?}.to_a, [2,4]
    end

    def test_to_a
        hash_to_a = CS253Array.new([1,2,3])
        range_to_a =CS253Array.new( [4,5,6])
        arr_to_a = CS253Array.new([[1,2,3],[4,5,6],(1..6)])
        triple_test= Triple.new(3,4,5)

        assert_equal triple_test.cs253to_a,[3,4,5]
        assert_equal hash_to_a.cs253to_a, [1,2,3]
        assert_equal range_to_a.cs253to_a, [4, 5, 6]
        assert_equal arr_to_a.cs253to_a, [[1, 2, 3], [4, 5, 6], 1..6]
    end

    def test_to_h
        arr_to_h1 = CS253Array.new([['animal',1],['fruit',2]])
        arr_to_h = CS253Array.new([['animal','cat'],['fruit','apple'], ['animal','dog']])
        triple_test= Triple.new(['a',3],['b',4],['c',5])

        assert_equal triple_test.cs253to_h,{"a"=>3,"b"=>4,"c"=>5}
        assert_equal arr_to_h1.cs253to_h,{"animal"=>1, "fruit"=>2}
        assert_equal arr_to_h.cs253to_h,{"animal"=>"dog", "fruit"=>"apple"}
    end

    def test_uniq
        int_uniq = CS253Array.new([1,1,2,3,1,4,6,2])
        int_uniq_two = CS253Array.new([1,2,3,4,5,5,2,6,8])
        str_uniq = CS253Array.new(['cat', 'dog','cat','mouse'])
        triple_test= Triple.new(3,4,5)

        assert_equal triple_test.cs253uniq{|i|i>2}.to_a,[3]
        assert_equal int_uniq.cs253uniq{|i| i.even?}.to_a, [1,2]
        assert_equal int_uniq_two.cs253uniq{|i| i}.to_a, [1,2,3,4,5,6,8]
        assert_equal str_uniq.cs253uniq{|i| i}.to_a, ['cat', 'dog','mouse']
    end

    def test_zip
        zip_one = CS253Array.new()
        zip_two = CS253Array.new()
        zip_three = CS253Array.new()
        triple_three = CS253Array.new()

        arr_one_zip = CS253Array.new([1,2,3])
        arr_two_zip = CS253Array.new([4,5,6,7])
        arr_three_zip = CS253Array.new(['cat','dog','mouse','duck'])
        triple_zip = Triple.new(3,4,5)

        arr_one_zip.cs253zip(arr_two_zip){|x,y| zip_one << x * y}
        arr_two_zip.cs253zip(arr_one_zip){|x,y| zip_two << [x, y]}
        arr_three_zip.cs253zip(arr_three_zip){|x,y| zip_three << [x, y.length]}
        triple_zip.cs253zip(triple_zip){|x,y| triple_three << x+y}

        assert_equal triple_three.to_a, [6, 8, 10]
        assert_equal zip_one.to_a, [4, 10, 18]
        assert_equal zip_two.to_a, [[4, 1], [5, 2], [6, 3], [7, nil]]
        assert_equal zip_three.to_a, [["cat", 3], ["dog", 3], ["mouse", 5], ["duck", 4]]
    end

    def test_length
        int_length = CS253Array.new([1,3,5,7,9])
        str_length = CS253Array.new(['cat','mouse','dog'])
        triple_test= Triple.new(3,4,5)

        assert_equal triple_test.cs253length.to_i,3
        assert_equal int_length.cs253length.to_i, 5
        assert_equal str_length.cs253length.to_i, 3

    end
    # more tests!
end



