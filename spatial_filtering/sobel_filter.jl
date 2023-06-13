using Images, FileIO

function set_mask(row, col, mask_size, y)
    max_iterator = div(mask_size, 2)
   
    key_positions = [(row, col, (2,2))]

    for i in 1:max_iterator
        pos_above_row = row-i
        if pos_above_row <= 0
            pos_above_row = row+i
        end

        pos_below_row = row+i
        if pos_below_row > y
            pos_below_row = pos_above_row
        end
        push!(key_positions, (pos_above_row, col, (2-i,2)))
        push!(key_positions, (pos_below_row, col, (2+i,2)))
    end

    surrounding_positions = []
    for pos in key_positions
        row, col, (x_in_filter, y_in_filter) = pos
        for i in 1:max_iterator

            next_pos = col+i
            if next_pos > y
                next_pos = col-i
            end

            previous_pos = col-i
            if previous_pos < 1
                previous_pos = next_pos
            end

            push!(surrounding_positions, (row, previous_pos, (x_in_filter, y_in_filter-1)))
            push!(surrounding_positions, (row, next_pos, (x_in_filter, y_in_filter+1)))
        end
    end

    append!(key_positions, surrounding_positions)
end

function run(x, y, image, mask_size, filter_matrix_x, filter_matrix_y)
    empty = zeros(x, y)

    for row in 1:x
        for col in 1:y
            g_of_x = 0
            values_g_of_x = set_mask(row, col, mask_size, y)

            for coord in values_g_of_x
                r, c, (coord_x_multiplier, coord_y_multiplier) = coord
                multiplier = filter_matrix_x[coord_x_multiplier, coord_y_multiplier]
                g_of_x += image[r,c].val*multiplier 
            end

            g_of_x = g_of_x*image[row, col]
            g_of_x = g_of_x*g_of_x

            g_of_y = 0
            values_g_of_y = set_mask(row, col, mask_size, y)

            for coord in values_g_of_y
                r, c, (coord_x_multiplier, coord_y_multiplier) = coord
                multiplier = filter_matrix_y[coord_x_multiplier, coord_y_multiplier]
                g_of_y += image[r,c].val*multiplier 
            end

            g_of_y = g_of_y*image[row, col]
            g_of_y = g_of_y*g_of_y

            empty[row, col] = sqrt(g_of_x + g_of_y)
        end
    end
    return empty
end

function main(path) 
    image = Gray.(load(path))

    #= image = Gray.(rand(3, 3)) =#

    x, y = size(image)

    matrix_x = [
        -1 0 1;
        -2 0 2;
        -1 0 1;
    ]

    matrix_y = [
        1 2 1;
        0 0 0;
        -1 -2 -1;
    ]

    save("sobel.jpeg", run(x, y, image, 3, matrix_x, matrix_y))
end

main("../images/pratica4.jpg")