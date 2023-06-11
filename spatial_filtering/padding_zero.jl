using Images, FileIO

image = Gray.(load("../images/pratica4.jpg"))

x, y = size(image)

function set_mask(row, col, mask_size)
    max_iterator = div(mask_size, 2)

    key_positions = [(row, col)]

    for i in 1:max_iterator
        push!(key_positions, (row-i, col))
        push!(key_positions, (row+i, col))
    end

    surrounding_positions = []
    for pos in key_positions
        row, col = pos
        for i in 1:max_iterator
            push!(surrounding_positions, (row, col-i))
            push!(surrounding_positions, (row, col+i))
        end
    end

    append!(key_positions, surrounding_positions)
end

function run()
    mask_size = 3
    total = mask_size*mask_size
    empty = zeros(x, y)

    for row in 1:x
        for col in 1:y
            sum = 0
            values = set_mask(row, col, mask_size)

            for coord in values
                r, c = coord
                try
                    sum += image[r,c].val
                catch
                    continue
                end
            end

            empty[row, col] = sum/total
        end
    end
    return empty
end

save("blur.jpeg", Gray.(run()))