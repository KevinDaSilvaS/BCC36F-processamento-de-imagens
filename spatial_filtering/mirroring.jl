using Images, FileIO

function set_mask(row, col, mask_size, y)
    max_iterator = div(mask_size, 2)
    key_positions = [(row, col)]

    for i in 1:max_iterator
        pos_above_row = row-i
        if pos_above_row <= 0
            pos_above_row = row+i
        end

        pos_below_row = row+i
        if pos_below_row > y
            pos_below_row = pos_above_row
        end
        push!(key_positions, (pos_above_row, col))
        push!(key_positions, (pos_below_row, col))
    end

    surrounding_positions = []
    for pos in key_positions
        row, col = pos
        for i in 1:max_iterator

            next_pos = col+i
            if next_pos > y
                next_pos = col-i
            end

            previous_pos = col-i
            if previous_pos < 1
                previous_pos = next_pos
            end

            push!(surrounding_positions, (row, previous_pos))
            push!(surrounding_positions, (row, next_pos))
        end
    end

    append!(key_positions, surrounding_positions)
end

function run(x, y, image)
    mask_size = 7
    total = mask_size*mask_size
    empty = zeros(x, y)

    for row in 1:x
        for col in 1:y
            sum = 0
            values = set_mask(row, col, mask_size, y)

            for coord in values
                r, c = coord
                sum += image[r,c].val
            end

            empty[row, col] = sum/total
        end
    end
    return empty
end

function main(path) 
    image = Gray.(load(path))

    x, y = size(image)

    save("blur01.jpeg", run(x, y, image))
end

main("../images/pratica4.jpg")