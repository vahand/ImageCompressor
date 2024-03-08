##
## EPITECH PROJECT, 2024
## FUN
## File description:
## Makefile
##

BINARYPATH =	$(shell stack path --local-install-root)

NAME = imageCompressor

all:
	stack build
	cp $(BINARYPATH)/bin/compressor-exe ./$(NAME)

clean:
	stack clean

fclean: clean
	rm $(NAME)

re: fclean all

.PHONY: all clean fclean
