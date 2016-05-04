            <div style="float:left; padding:12px; margin:20px 10px 0px; border:solid 1px #431; font-weight:900; ">
                <div style="width:100%; text-align:center; margin:2px 0px 10px; text-decoration:underline; font-weight:400; ">Detail Navigation</div>
                <div><span class="CommunityDetailHeaderLink"><a href="./">Communities List</a></span></div>
                <div><span class="CommunityDetailHeaderLink"><a href="<?= $this->rootDir . $this->curPage ?>?commid=<?= $this->curComm->id ?>">Community</a></span></div>
                <div><span class="CommunityDetailHeaderLink"><a href="<?= $this->rootDir . $this->curPage ?>?panel=2&commid=<?= $this->curComm->id ?>">Plat Map</a></span></div>
                <div><span class="CommunityDetailHeaderLink"><a href="<?= $this->rootDir . $this->curPage ?>?panel=3&commid=<?= $this->curComm->id ?>">Floor Plans</a></span></div>
                <div><span class="CommunityDetailHeaderLink"><a href="<?= $this->rootDir . $this->curPage ?>?panel=5&commid=<?= $this->curComm->id ?>">Home Specs</a></span></div>
                <div><span class="CommunityDetailHeaderLink"><a href="<?= $this->rootDir . $this->curPage ?>?panel=6&commid=<?= $this->curComm->id ?>">Directions</a></span></div>
                <div><span class="CommunityDetailHeaderLink"><a href="<?=$this->rootDir?>contact/?commid=<?= $this->curComm->id ?>">Contact Us</a></span></div>
            </div>
