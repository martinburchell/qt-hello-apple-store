#include <QApplication>
#include <QDebug>
#include <QDialog>
#include <QLabel>
#include <QVBoxLayout>

class HelloDialog : public QDialog
{
    Q_OBJECT
public:
    HelloDialog(QWidget* parent) :  QDialog(parent)
    {
        auto prompt = new QLabel("Hello Apple Store!");
        prompt->setWordWrap(true);

        auto mainlayout = new QVBoxLayout();
        mainlayout->addWidget(prompt);
        mainlayout->addStretch(1);

        setLayout(mainlayout);
    }
};

#if defined __clang__  // NB defined in Qt Creator; put this first for that reason
    #define COMPILER_IS_CLANG
    #if __clang_major__ >= 10
        #define CLANG_AT_LEAST_10
    #endif
#elif defined __GNUC__  // __GNUC__ is defined for GCC and clang
    #define COMPILER_IS_GCC
    #if __GNUC__ >= 7  // gcc >= 7.0
        #define GCC_AT_LEAST_7
    #endif
#elif defined _MSC_VER
    #define COMPILER_IS_VISUAL_CPP
#endif


#if defined COMPILER_IS_CLANG || defined COMPILER_IS_GCC
    #define VISIBLE_SYMBOL __attribute__ ((visibility ("default")))
#elif defined COMPILER_IS_VISUAL_CPP
    #define VISIBLE_SYMBOL __declspec(dllexport)
#else
    #error "Don't know how to enforce symbol visibility for this compiler!"
#endif


VISIBLE_SYMBOL int main(int argc, char* argv[]){
    QApplication app(argc, argv);
    HelloDialog dialog(nullptr);
    dialog.exec();

    return app.exec();
}

#include "main.moc"
