##
## EPITECH PROJECT, 2024
## FUN
## File description:
## Makefile
##

BINARYPATH =	$(shell stack path --local-install-root)

NAME = compressor

all:
	stack build
	cp $(BINARYPATH)/bin/$(NAME)-exe ./$(NAME)

clean:
	stack clean

fclean: clean
	rm $(NAME)

re: fclean all

.PHONY: all clean fclean
