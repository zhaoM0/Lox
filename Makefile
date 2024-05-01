# 设置变量
SRC_DIR := jlox
BIN_DIR := bin
JAVAC := javac
JAVA := java

# 指定编译选项
JAVAC_FLAGS := -d $(BIN_DIR)

# 定义源文件列表
SOURCES := $(wildcard $(SRC_DIR)/*.java)

# 定义目标文件列表
CLASSES := $(SOURCES:$(SRC_DIR)/%.java=$(BIN_DIR)/%.class)

# 默认目标：编译所有的源文件
all: $(CLASSES) $(BIN_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# 将Java源文件编译为class文件
$(BIN_DIR)/%.class: $(SRC_DIR)/%.java
	@if [ ! -f $@ ] || [ $< -nt $@ ]; then \
		echo "Compiling $<"; \
		$(JAVAC) $(JAVAC_FLAGS) $<; \
	fi

# 运行程序
run: all
	$(JAVA) -cp $(BIN_DIR) $(SRC_DIR).Lox

# 清理生成的文件
clean:
	$(RM) $(BIN_DIR)/*.class
