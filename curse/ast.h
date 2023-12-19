struct ast{
    int nodetype;
    struct ast *l;
    struct ast *r;
};

struct nodevar{
    int nodetype;
    char function;
    int derivative;
};

struct nodeconst{
    int nodetype;
    double number;
    int derivative;
};

struct ast* newast(int nodetype, struct ast * l, struct ast * r);
struct ast* newnode1(int function);
struct ast* newnode2(double number);

void eval(struct ast*);

void treefree(struct ast*);