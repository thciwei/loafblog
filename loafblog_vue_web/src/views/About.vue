<template>
  <div class="about">
    <div class="site-content">
      <div class="content-warp">
        <div class="about-site about-info">
          <section-title><span>❤</span>关于博客</section-title>
          <div class="info-card">
            <p>再见吧，我的朋友 艰难的种子已经裂开，哀伤的挽留充满了道路。我的朋友，高兴时我会为你留下一串脚印,不高兴时我也不会阻挡你的春光。雪,很快就会化掉，放浪的云彩也会超过你们的期望。</p>
          </div>
        </div>
        <div class="about-me about-info">
          <section-title id="Guestbook"><span>❤</span>给我留言</section-title>
          <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="100px"
                   class="rule-form">
            <div class="info-card">
              <div class="contactForm">
                <el-form-item label="邮箱" prop="mail">
                  <div class="form-item">
                    <!--                  <label for="mail">邮箱</label>-->
                    <el-input class="v" type="email" name="mail" id="mail" v-model="ruleForm.mail"/>
                  </div>
                </el-form-item>
                <el-form-item label="内容" prop="content">
                  <div class="form-item">
                    <!--                    <label for="content">内容</label>-->
                    <el-input type="textarea" :autosize="{ minRows: 2, maxRows: 4}" placeholder="请输入内容" class="v"
                              id="content" name="content" v-model="ruleForm.content"></el-input>
                  </div>
                </el-form-item>
                <el-form-item>
                  <div class="form-item">
                    <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
                  </div>
                </el-form-item>
              </div>
            </div>
          </el-form>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import sectionTitle from '@/components/section-title'
import {getTime, getTimeInterval} from '@/utils'
// import Quote from "@/components/quote";
// import {fetchFriend} from '../api'
export default {
  name: "About",
  data() {
    return {
      list: [],
      ruleForm: {
        mail: '',
        content: '',
      },
      rules: {
        mail: [
          { required: true, message: '请输入您的邮箱', trigger: 'blur' },
        ],
        content: [
          { required: true, message: '请输入您的站点名称、链接、介绍', trigger: 'blur' },
        ],
      }

    }
  },
  components: {
    // Quote,
    sectionTitle
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          console.log(this.ruleForm)
          this.postRequest("/blog/info/save",this.ruleForm).then(resp=>{
            if (resp){
              this.$message({
                message: '马上我就会回复你啦',
                type: 'success'
              });
              this.ruleForm.mail=''
              this.ruleForm.content=''
            }
          })
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
  },
  mounted() {
  }
}
</script>
<style scoped lang="less">
.rule-form {
  /deep/ .el-form-item__label {
    font-size: 20px;
  }

}

.about {
  padding-top: 40px;
}

.content-warp {
  margin-top: 80px;

  .about-info {
    margin: 30px 0;

    span {
      color: red;
      margin-right: 10px;
    }

    .info-card {
      min-height: 100px;
      padding: 20px;
      border-radius: 3px;
      margin: 30px 0 50px 0;
      box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);

      p {
        line-height: 1.7rem;
      }
    }
  }

  .contactForm {
    width: 100%;
    padding: 20px;

    .form-item {
      align-items: center;
      display: flex;

      &:not(:last-child) {
        margin-bottom: 20px;
      }

      label {
        width: 80px;
      }

      .v {
        min-height: 40px;
        line-height: 20px;
        border-radius: 3px;
        padding: 2px 10px;
        outline: none;
        //border: 1px solid #8fd0cc;
        width: 100%;
        resize: vertical;
      }

      button {
        width: 100px;
        height: 40px;
        border-radius: 3px;
        outline: 0;
        border-style: none;
        cursor: pointer;
        background-color: #409eff;
        color: white;

        &:hover {
          opacity: 0.8;
        }
      }
    }
  }
}

/*******/
@media (max-width: 800px) {
  .content-warp {
    margin-top: 0;
  }
}
</style>
